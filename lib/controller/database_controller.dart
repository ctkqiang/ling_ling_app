import 'package:get/get.dart';
import 'package:ling_ling_app/core/linling_db.dart';

class DatabaseController extends GetxController implements LingLingDb {
  static DatabaseController get to => Get.put(DatabaseController.create());

  DatabaseController._();
  DatabaseController.create() : this._();

  @override
  Future<void> getUserCountryCode() {
    // TODO: implement getUserCountryCode
    throw UnimplementedError();
  }
}
