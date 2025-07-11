import 'package:flutter/foundation.dart';
import 'package:flutter_defend/flutter_defend.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ling_ling_app/core/linling_db.dart';
import 'package:ling_ling_app/models/database/scammers_data.dart';
import 'package:ling_ling_app/models/database/users.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v6.dart';

class DatabaseController extends GetxController implements LingLingDb {
  static DatabaseController get to => Get.put(DatabaseController.create());

  DatabaseController._();
  DatabaseController.create() : this._();

  static Database? _db;

  final scammerTableName = 'scammers';
  final version = 1;

  final logger = Logger();
  final getStorage = GetStorage();
  final storage = FlutterDefend.secureStorage;

  final RxString username = ''.obs;

  Future<Database> get database async {
    _db ??= await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(path, version: version, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $scammerTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT,
        reportedBy TEXT,
        vote INTEGER,
        createdAt TEXT
      )
    ''');
  }

  @override
  Future<void> getUserCountryCode() {
    throw UnimplementedError();
  }

  @override
  Future<List<ScammersData>> getScammersData() {
    throw UnimplementedError();
  }

  @override
  Future<int> insert(ScammersData scammerData) async {
    final db = await database;
    final response = await db.insert(scammerTableName, scammerData.toMap());

    if (kDebugMode) logger.i('Inserted scammer data with ID: $response');

    return response;
  }

  @override
  Future<int> delete(ScammersData scammerData) async {
    final db = await database;
    final response = await db.delete(
      scammerTableName,
      where: 'id = ?',
      whereArgs: [scammerData.id],
    );

    if (kDebugMode) logger.i('Deleted scammer data with ID: $response');

    return response;
  }

  @override
  Future<int> upsert(ScammersData scammerData) async {
    final db = await database;
    final response = await db.update(scammerTableName, scammerData.toMap());

    if (kDebugMode) logger.i('Updated scammer data with ID: $response');

    return response;
  }

  Future<void> createLocalUser({required String user}) async {
    assert(user.isNotEmpty, "用户 name 不能为空！");

    final userStorage = FlutterDefend.withPassphrase("username-salted");
    final cUser = userStorage.cipher(user, 30);

    if (kDebugMode) logger.i("📤 写入用户: $cUser");

    await getStorage.write('user', cUser);
    await userStorage.write('user', cUser);
  }

  Future<void> getUser() async {
    final user = await getStorage.read("user");

    logger.i("📥 读取到用户: $user");

    username.value = user ?? "hashed_${Uuid().v6()}";
    notifyChildrens();

    return;
  }
}
