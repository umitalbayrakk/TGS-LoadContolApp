import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.generalBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.whiteSpot, size: 30),
        backgroundColor: AppColors.snackBarRed,
        title: const Text(
          "Geri Bildirim",
          style: TextStyle(
            color: AppColors.whiteSpot,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Adınız",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Soyadınız",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  hintText: "E-posta Adresiniz",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Lütfen Geri bildiriminizi yazın...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                height: 50,
                minWidth: 300,
                onPressed: () {},
                color: AppColors.greenSpot,
                child: const Text(
                  "Geri Bildirim Gönder",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("TURKISH GROUND SERVICES",
                  style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ),
    );
  }
}
