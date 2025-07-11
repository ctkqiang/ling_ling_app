// ignore_for_file: constant_pattern_never_matches_value_type

import 'dart:io';

import 'package:another_telephony/telephony.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ling_ling_app/core/ling_ling_call_logic.dart';
import 'package:ling_ling_app/models/contacts.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

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
    try {
      if (phoneNumber.value.isEmpty) return;
      if (kDebugMode) logger.i('📞 正在拨打: $phoneNumber');

      if (!Platform.isAndroid) {
        Get.snackbar(
          '不支持的平台',
          '目前仅支持 Android 拨号哦~',
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      await telephony.dialPhoneNumber(phoneNumber.value);
    } catch (e) {
      logger.e('拨号失败: $e');
      Get.snackbar(
        '拨号失败',
        '发生未知错误: $e',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
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

    final state = telephony.callState; // IDLE, RINGING, OFFHOOK, UNKNOWN

    if (kDebugMode) logger.i('[通话状态 INIT]: $state');

    switch (state) {
      case CallState.IDLE:
        logger.i('📞 当前状态: 无通话');
        break;
      case CallState.RINGING:
        logger.i('📞 当前状态: 响铃中');
        break;
      case CallState.OFFHOOK:
        logger.i('📞 当前状态: 通话中');
        break;
      default:
        break;
    }
  }

  Future<void> callNumber(String number) async {
    if (number.trim().isEmpty) {
      Get.snackbar('拨号失败', '号码不能为空');
      return;
    }

    final uri = Uri(scheme: 'tel', path: number.trim());

    try {
      final bool canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        final bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          Get.snackbar('拨号失败', '无法唤起拨号器');
        } else {
          if (kDebugMode) {
            print('📞 已唤起拨号器: $number');
          }
        }
      } else {
        Get.snackbar('拨号失败', '无法拨打该号码');
      }
    } catch (e) {
      Get.snackbar('拨号失败', '发生错误: $e');
      if (kDebugMode) {
        print('❌ 拨号异常: $e');
      }
    }
  }
}
