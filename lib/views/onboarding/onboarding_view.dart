import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/login/login_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  LoginPage()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        colors: [
          AppColors.greenSpot,
          AppColors.greenSpot,
        ],
        end: Alignment.bottomCenter,
      )),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Center(
            child: Text(
              "TGS",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Center(
            child: Text(
              "LOAD CONTROL",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      ),
    ));
  }
}
