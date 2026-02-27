import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calculator_view.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorScreen(
      onThemeToggle: () {
        Get.changeThemeMode(
          Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
        );
      },
    );
  }
}
