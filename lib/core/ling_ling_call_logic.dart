import 'package:ling_ling_app/models/contacts.dart';

abstract class LingLingCallLogic {
  Future<void> call();
  Future<void> saveContact(Contacts contacts);
}
