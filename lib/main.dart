import 'package:flutter/material.dart';
import 'package:ling_ling_app/presentation/app.dart';

const appName = "灵玲 APP";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = LingLingApp(appName: appName);

  runApp(app);
}
