import 'package:flutter/material.dart';
import 'package:load_control_project/service/auth.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/widgets/navbar/custom_navbar_widgets.dart';
import 'package:load_control_project/views/widgets/snackbar/snackbar_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = true;

  // Kayıt olma işlemi
  Future<void> createUser() async {
    try {
      await Auth().createUser(_emailController.text, _passwordController.text);
      showCustomSnackbar(context, "Kayıt Başarılı! Giriş Yapabilirsiniz.", isError: true);
      setState(() => isLogin = true);
    } on Exception {
      showCustomErrorSnackbar(context, "Kayıt Başarısız! Lütfen Tekrar Deneyin.");
    }
  }

  // Giriş yapma işlemi
  Future<void> signIn() async {
    try {
      await Auth().signIn(_emailController.text, _passwordController.text);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CustomNavbarWidgets()),
        );
      }
    } on Exception {
      showCustomErrorSnackbar(context, "Giriş Başarısız! Bilgilerinizi Kontrol Edin.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: AppColors.generalBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.flight_takeoff, size: 32),
                  SizedBox(width: 12),
                  Text(
                    "TGS",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.borderColor,
                      letterSpacing: 4.0,
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: AppColors.borderColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "KONTROL SİSTEMİ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              backgroundColor: AppColors.greenSpot,
              maxRadius: 100,
              child: Icon(Icons.person_2, size: 150, color: Colors.white),
            ),
            const SizedBox(height: 20),
            // Email TextField - Sabit genişlik
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: screenWidth * 0.8, // %80 ekran genişliği
                child: TextField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "E-posta",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // TextField'lar arası boşluk
            // Password TextField - Sabit genişlik
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: screenWidth * 0.8, // %80 ekran genişliği
                child: TextField(
                  controller: _passwordController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Şifre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            MaterialButton(
              height: 50,
              minWidth: screenWidth * 0.8, // TextField ile aynı genişlik
              onPressed: () async {
                if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                  showCustomErrorSnackbar(context, "Lütfen Tüm Alanları Doldurunuz!");
                  return;
                }
                if (isLogin) {
                  showCustomSnackbar(context, "Giriş Yapıldı", isSuccess: true, isError: true);
                  await signIn(); // Giriş işlemi
                } else {
                  await createUser(); // Kayıt işlemi
                  showCustomSnackbar(context, "Kayıt Başarılı", isError: true);
                }
              },
              color: AppColors.greenSpot,
              child: Text(
                isLogin ? "Giriş Yap" : "Kayıt Ol",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => setState(() => isLogin = !isLogin),
              child: Text(
                isLogin ? "Henüz Hesabın Yoksa Kayıt Ol!" : "Zaten Hesabın Var mı? Giriş Yap!",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(height: 100),
            const Text(
              "TURKISH GROUND SERVICES",
              style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
