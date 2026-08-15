import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_profile.dart';
import '../repository/user_repository.dart';
import '../repository/user_repository_provider.dart';

final userViewModelProvider = AsyncNotifierProvider<
    UserViewModel,
    UserProfile?>(
  UserViewModel.new,
);

class UserViewModel
    extends AsyncNotifier<UserProfile?> {
  late final UserRepository _repository;

  @override
  Future<UserProfile?> build() async {
    _repository =
        ref.read(userRepositoryProvider);

    return null;
  }

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.createUserProfile(
        uid: uid,
        name: name,
        email: email,
      );

      return await _repository.getUserProfile(uid);
    });
  }

  Future<void> getUserProfile(
      String uid,
      ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _repository.getUserProfile(uid);
    });
  }

  Future<void> updateUserProfile({
    required String uid,
    String? name,
    String? phone,
    String? profileImage,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.updateUserProfile(
        uid: uid,
        name: name,
        phone: phone,
        profileImage: profileImage,
      );

      return await _repository.getUserProfile(uid);
    });
  }

  Future<void> deleteUserProfile(
      String uid,
      ) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.deleteUserProfile(uid);

      return null;
    });
  }
}