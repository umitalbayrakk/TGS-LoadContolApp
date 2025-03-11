import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';

class CardWidgets extends StatelessWidget {
  const CardWidgets({
    super.key, required String title, required String subtitle, required Future<void> Function() onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: AppColors.appBarColor,
        child: ListTile(
          trailing: Container(
            decoration: BoxDecoration(color: AppColors.snackBarGreen, borderRadius: BorderRadius.circular(10)),
            height: 100,
            width: 20,
          ),
          leading: const Text(
            "1",
            style: TextStyle(fontSize: 20),
          ),
          title: const Text("25.02.2025 / TK 2051 / G10\nTC-JJA "),
          textColor: Colors.black,
          subtitle: const Text("HASAN CAN / FEHMİ YILMAZ"),
        ),
      ),
    );
  }
}
