import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ling_ling_app/main.dart';
import 'package:ling_ling_app/presentation/pages/spalsh.dart';

class LingLingApp extends StatefulWidget {
  final String appName;
  const LingLingApp({required this.appName, super.key});

  @override
  State<LingLingApp> createState() => _LingLingAppState();
}

class _LingLingAppState extends State<LingLingApp> {
  void setSystemBars({required bool isDarkMode}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // ✅ 透明状态栏
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: isDarkMode
            ? Colors.black
            : Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: Key("$appName:main"),
      title: widget.appName,
      theme: ThemeData(
        primaryColor: Colors.pink.shade300,
        appBarTheme: AppBarTheme(
          color: Colors.pink.shade100,
          elevation: 0.0,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      builder: (context, child) {
        final isDark =
            MediaQuery.of(context).platformBrightness == Brightness.dark;
        setSystemBars(isDarkMode: isDark); // ✅ 放这里就对了！

        return child!;
      },
      color: Colors.pink.shade100,
      enableLog: kDebugMode,
      locale: Locale("zh"),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: SplashPage(key: Key('$appName:splash'), duration: 5),
    );
  }
}
