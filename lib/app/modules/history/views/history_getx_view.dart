import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'history_view.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return HistoryScreen(
      onSelectHistory: (value) {
        Get.back(result: value);
      },
    );
  }
}
