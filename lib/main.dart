import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_theme_kit/zen_theme_kit.dart';
import 'app/routes/app_pages.dart';
import 'app/config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ZenTheme(
      data: ZenThemeData.sandGarden(),
      child: GetMaterialApp(
        title: 'ZenCalc',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
