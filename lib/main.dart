import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ling_ling_app/controller/dialer_controller.dart';
import 'package:ling_ling_app/presentation/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const appName = "灵玲反诈";

final DialerController dialerController = DialerController.to;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final app = LingLingApp(appName: appName);
  final url = dotenv.env['SUPABASE_URL'];
  final anonKey = dotenv.env['ANON_KEY'];

  await Supabase.initialize(url: url!, anonKey: anonKey!);

  runApp(app);
}
