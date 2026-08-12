import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/app_user.dart';
import '../repository/auth_repository.dart';
import '../repository/auth_repository_provider.dart';

final authViewModelProvider =
AsyncNotifierProvider<AuthViewModel, AppUser?>(
  AuthViewModel.new,
);

class AuthViewModel extends AsyncNotifier<AppUser?> {
  late final AuthRepository _repository;

  @override
  Future<AppUser?> build() async {
    _repository = ref.read(authRepositoryProvider);

    return _repository.currentUser;
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
          () async {
        return await _repository.register(
          email: email,
          password: password,
        );
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
          () async {
        return await _repository.login(
          email: email,
          password: password,
        );
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
          () async {
        await _repository.logout();
        return null;
      },
    );
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
          () async {
        await _repository.sendPasswordResetEmail(
          email: email,
        );

        return state.value;
      },
    );
  }

  Future<void> sendEmailVerification() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
          () async {
        await _repository.sendEmailVerification();

        return _repository.currentUser;
      },
    );
  }

  Future<void> reloadUser() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
          () async {
        return await _repository.reloadUser();
      },
    );
  }
}