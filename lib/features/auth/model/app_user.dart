import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  // =========================
  // Firebase Auth
  // =========================

  final String uid;
  final String? email;
  final bool emailVerified;

  // =========================
  // Firestore Profile
  // =========================

  final String name;
  final String? phone;
  final String? profileImage;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AppUser({
    required this.uid,
    this.email,
    required this.name,
    this.phone,
    this.profileImage,
    this.emailVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  // =========================
  // Firebase Auth User
  // =========================

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      name: user.displayName ?? '',
      profileImage: user.photoURL,
      emailVerified: user.emailVerified,
    );
  }

  // =========================
  // Firestore
  // =========================

  factory AppUser.fromMap(
      Map<String, dynamic> map,
      ) {
    return AppUser(
      uid: map['uid'] ?? '',
      email: map['email'],
      name: map['name'] ?? '',
      phone: map['phone'],
      profileImage: map['profileImage'],
      emailVerified: map['emailVerified'] ?? false,
      createdAt: _parseDateTime(map['createdAt']),
      updatedAt: _parseDateTime(map['updatedAt']),
    );
  }

  // =========================
  // To Firestore
  // =========================

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'profileImage': profileImage,
      'emailVerified': emailVerified,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // =========================
  // Timestamp / DateTime Helper
  // =========================

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return null;
  }
}