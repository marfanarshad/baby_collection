import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_profile.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({
    FirebaseFirestore? firestore,
  }) : _firestore =
      firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
  get _usersCollection =>
      _firestore.collection('users');

  // =========================
  // Create User Profile
  // =========================

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _usersCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'phone': null,
      'profileImage': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // =========================
  // Get User Profile
  // =========================

  Future<UserProfile?> getUserProfile(
      String uid,
      ) async {
    final snapshot =
    await _usersCollection.doc(uid).get();

    if (!snapshot.exists) {
      return null;
    }

    return UserProfile.fromMap(
      snapshot.data()!,
    );
  }

  // =========================
  // Update User Profile
  // =========================

  Future<void> updateUserProfile({
    required String uid,
    String? name,
    String? phone,
    String? profileImage,
  }) async {
    final data = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (name != null) {
      data['name'] = name;
    }

    if (phone != null) {
      data['phone'] = phone;
    }

    if (profileImage != null) {
      data['profileImage'] = profileImage;
    }

    await _usersCollection.doc(uid).update(data);
  }

  // =========================
  // Delete User Profile
  // =========================

  Future<void> deleteUserProfile(
      String uid,
      ) async {
    await _usersCollection.doc(uid).delete();
  }
}