import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';
import '../model/app_user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StreamProvider<AppUser?>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return repository.authStateChanges();
});