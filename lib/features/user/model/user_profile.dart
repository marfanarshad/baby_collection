class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromMap(
      Map<String, dynamic> map,
      ) {
    return UserProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      profileImage: map['profileImage'],
      createdAt: map['createdAt']?.toDate(),
      updatedAt: map['updatedAt']?.toDate(),
    );
  }
}