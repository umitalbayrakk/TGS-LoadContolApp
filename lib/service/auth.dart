import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
// Register auth
  Future<void> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      print("Kullanıcı başarıyla kaydedildi: $email");
    } on FirebaseAuthException catch (e) {
      print("Kayıt Hatası: ${e.message}"); 
      throw Exception(e.message);
    }
  }

// Login auth
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      print("Kullanıcı başarıyla giriş yaptı: $email");
    } on FirebaseAuthException catch (e) {
      print("Giriş Hatası: ${e.message}");
      throw Exception(e.message);
    }
  }

// SignOut auth
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
