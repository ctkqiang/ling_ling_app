import 'package:ling_ling_app/models/contacts.dart';

abstract class LinglingOsReq {
  Future<void> setDefault();
  Future<void> requestToRunInBackground();

  Future<List<Contacts>> getContacts(bool isPermissionGranted);
  Future<void> openAppSettings();
  Future<void> openAppInfo();
}
