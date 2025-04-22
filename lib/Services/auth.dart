import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
// Anonymous Sign In
Future<User?> signInAnon() async {
  try {
    UserCredential result = await _auth.signInAnonymously();
    User? user = result.user;

    if (user != null) {
      print('Signed in anonymously with UID: ${user.uid}');
    }

    return user;
  } catch (e) {
    print('Error signing in anonymously: $e');
    return null;
  }
}

// Sign In with Email and Password
Future<User?> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  } catch (e) {
    print('Error signing in: $e');
    return null;
  }
}
  //register eith email and password

  //sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}