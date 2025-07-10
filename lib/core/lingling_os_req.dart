import 'package:ling_ling_app/models/contacts.dart';

abstract class LinglingOsReq {
  void setDefault();

  Future<List<Contacts>> getContacts(bool isPermissionGranted);
  Future<void> openAppSettings();
  Future<void> openAppInfo();
}
