import 'package:ling_ling_app/models/database/scammers_data.dart';
import 'package:sqflite/sqflite.dart';

abstract class LingLingDb {
  Future<void> getUserCountryCode();
  Future<List<ScammersData>> getScammersData();
  Future<Database> insert(ScammersData scammerData);
}
