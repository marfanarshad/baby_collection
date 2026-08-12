import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String authMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';

      case 'email-already-in-use':
        return 'An account already exists with this email.';

      case 'weak-password':
        return 'Password is too weak.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      default:
        return 'Authentication failed. Please try again.';
    }
  }
}