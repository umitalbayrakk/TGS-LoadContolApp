import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:load_control_project/firebase_options.dart';
import 'package:load_control_project/views/onboarding/onboarding_view.dart';

void main() async {
  // Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Load Control Project',
      home: OnboardingView(),
    );
  }
}

//test@gmail.com
