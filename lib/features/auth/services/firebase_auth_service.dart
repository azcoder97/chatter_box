import 'package:chatter_box/core/utils/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler.handleAuthException(e);
    }
  }

  Future<User?> signUp(String email, String password, String fullName) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        // ✅ Store name in FirebaseAuth for now
        await user.updateDisplayName(fullName);
        await user.reload(); // Refresh user object
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler.handleAuthException(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler.handleAuthException(e);
    }
  }

  Future<void> signOut() => _auth.signOut();
}
