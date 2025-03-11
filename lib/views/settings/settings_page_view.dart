import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({super.key});

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.generalBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.whiteSpot, size: 30),
        backgroundColor: AppColors.snackBarRed,
        title: const Text(
          'Ayarlar',
          style: TextStyle(color: AppColors.whiteSpot, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: AppColors.appBarColor,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.light_mode)),
                  const SizedBox(width: 20),
                  const Text("Tema:"),
                  const SizedBox(width: 20),
                  const Spacer(),
                  const SwitchExample(),
                  const SizedBox(width: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool isTrue = false;
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: AppColors.switchColor,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
