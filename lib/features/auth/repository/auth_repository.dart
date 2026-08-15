import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utils/firebase_error_handler.dart';
import '../model/app_user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // =========================
  // Register
  // =========================

  Future<AppUser> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception(
          'Registration failed.',
        );
      }

      await user.sendEmailVerification();

      return AppUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(
        FirebaseErrorHandler.authMessage(e),
      );
    }
  }

  // Future<AppUser> register({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final credential =
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     final user = credential.user;
  //
  //     if (user == null) {
  //       throw Exception('Registration failed.');
  //     }
  //
  //     return AppUser.fromFirebaseUser(user);
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(
  //       FirebaseErrorHandler.authMessage(e),
  //     );
  //   }
  // }

  // =========================
  // Login
  // =========================

  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('Login failed.');
      }

      return AppUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(
        FirebaseErrorHandler.authMessage(e),
      );
    }
  }

  // =========================
  // Logout
  // =========================

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // =========================
  // Forgot Password
  // =========================

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(
        FirebaseErrorHandler.authMessage(e),
      );
    }
  }

  // =========================
  // Send Email Verification
  // =========================

  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('No authenticated user found.');
      }

      if (user.emailVerified) {
        return;
      }

      await user.sendEmailVerification();

      print('✅ Verification email request sent to: ${user.email}');
    } on FirebaseAuthException catch (e) {
      print('❌ Firebase verification error: ${e.code}');
      print('❌ Message: ${e.message}');

      throw Exception(
        FirebaseErrorHandler.authMessage(e),
      );
    } catch (e) {
      print('❌ Verification error: $e');
      rethrow;
    }
  }

  // Future<void> sendEmailVerification() async {
  //   try {
  //     final user = _firebaseAuth.currentUser;
  //
  //     if (user == null) {
  //       throw Exception('No authenticated user found.');
  //     }
  //
  //     if (!user.emailVerified) {
  //       await user.sendEmailVerification();
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(
  //       FirebaseErrorHandler.authMessage(e),
  //     );
  //   }
  // }

  // =========================
  // Reload User
  // =========================

  Future<AppUser?> reloadUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return null;
      }

      await user.reload();

      final updatedUser = _firebaseAuth.currentUser;

      if (updatedUser == null) {
        return null;
      }

      return AppUser.fromFirebaseUser(updatedUser);
    } on FirebaseAuthException catch (e) {
      throw Exception(
        FirebaseErrorHandler.authMessage(e),
      );
    }
  }

  // =========================
  // Auth State Stream
  // =========================

  Stream<AppUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(
          (user) {
        if (user == null) {
          return null;
        }

        return AppUser.fromFirebaseUser(user);
      },
    );
  }

  // =========================
  // Current User
  // =========================

  AppUser? get currentUser {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    return AppUser.fromFirebaseUser(user);
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/utils/firebase_error_handler.dart';
// import '../model/app_user.dart';
//
// class AuthRepository {
//   final FirebaseAuth _firebaseAuth;
//
//   AuthRepository({
//     FirebaseAuth? firebaseAuth,
//   }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
//
//   Future<AppUser> register({
//     required String email,
//     required String password,
//   }) async {
//     final credential =
//     await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//
//     final user = credential.user;
//
//     if (user == null) {
//       throw Exception('User registration failed.');
//     }
//
//     return AppUser.fromFirebaseUser(user);
//   }
//
//   Future<AppUser> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final credential =
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       final user = credential.user;
//
//       if (user == null) {
//         throw Exception('Login failed.');
//       }
//
//       return AppUser.fromFirebaseUser(user);
//     } on FirebaseAuthException catch (e) {
//       throw Exception(
//         FirebaseErrorHandler.authMessage(e),
//       );
//     }
//   }
//
//   Future<void> logout() async {
//     await _firebaseAuth.signOut();
//   }
// }