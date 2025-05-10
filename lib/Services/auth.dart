import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Anonymous Sign In
  Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      print('Signed in anonymously with UID: ${user?.uid}');
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

  // Register User (Only customers allowed)
 Future<void> registerUser({
  required String email,
  required String password,
  required String role, // Should be "customer"
  required String fullName,
}) async {
  if (role != 'customer') {
    throw Exception('Only customers can register through the app.');
  }

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'role': role, // Will be "customer"
      'createdAt': FieldValue.serverTimestamp(),
    });

    print('Customer registered: $uid');
  } catch (e) {
    print('Error registering customer: $e');
    rethrow;
  }
}


  // Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}