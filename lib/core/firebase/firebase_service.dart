import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUser(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception('An unknown error occurred.');
      }
    } catch (e) {
      print("something went wrong $e");
    }
    return null;
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      print("something went wrong $e");
    }
    return null;
  }

  Future<User?> signOutUser(String email, String password) async {
    try {
      final cred = await _auth.signOut();
    } catch (e) {
      print("something went wrong $e");
    }
    return null;
  }
}