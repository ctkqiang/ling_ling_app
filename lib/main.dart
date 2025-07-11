import 'package:flutter/material.dart';
import 'package:ling_ling_app/controller/dialer_controller.dart';
import 'package:ling_ling_app/presentation/app.dart';

const appName = "灵玲 APP";

final DialerController dialerController = DialerController.to;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = LingLingApp(appName: appName);

  runApp(app);
}
