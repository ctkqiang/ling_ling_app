import 'dart:io';

import 'package:another_telephony/telephony.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ling_ling_app/core/ling_ling_call_logic.dart';
import 'package:ling_ling_app/models/contacts.dart';
import 'package:logger/logger.dart';

class DialerController extends GetxController implements LingLingCallLogic {
  static DialerController get to => Get.put(DialerController.create());

  DialerController._();
  DialerController.create() : this._();

  final Logger logger = Logger();
  final Telephony telephony = Telephony.instance;

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

  void deleteAll() {
    if (phoneNumber.value.isNotEmpty) {
      phoneNumber.value = phoneNumber.value.substring(
        0,
        phoneNumber.value.length - phoneNumber.value.length,
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

  @pragma('vm:entry-point')
  Future<void> initTelephony() async {
    if (!Platform.isAndroid) return;

    bool? isPermissionsGranted = await telephony.requestPhoneAndSmsPermissions;

    if (!isPermissionsGranted! && kDebugMode) {
      logger.e('[TELEPHONY] 权限未授权');
    }
    

    telephony.listenIncomingSms(
      onNewMessage: (message) {
        logger.i('📩 新短信: ${message.body}');
      },
    );
  }
}
