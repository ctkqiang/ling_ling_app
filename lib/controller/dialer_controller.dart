import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ling_ling_app/core/ling_ling_call_logic.dart';
import 'package:ling_ling_app/models/contacts.dart';

class DialerController extends GetxController implements LingLingCallLogic {
  static DialerController get to => Get.put(DialerController.create());

  DialerController._();
  DialerController.create() : this._();

  final RxString phoneNumber = ''.obs;

  void clear() => phoneNumber.value = '';

  void append(String value) {
    phoneNumber.value += value;

    HapticFeedback.lightImpact();
  }

  void delete() {
    if (phoneNumber.value.isNotEmpty) {
      phoneNumber.value = phoneNumber.value.substring(
        0,
        phoneNumber.value.length - 1,
      );
    }
  }

  @override
  Future<void> saveContact(Contacts contacts) {
    throw UnimplementedError();
  }

  @override
  Future<void> call() async {
    if (phoneNumber.isNotEmpty) {
      Get.snackbar(
        "正在拨打",
        phoneNumber.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
