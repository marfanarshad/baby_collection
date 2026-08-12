import 'package:baby_collection/features/auth/view/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/view/home_screen.dart';
import '../repository/auth_repository_provider.dart';
import 'login_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },

      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text(
              'Authentication error',
            ),
          ),
        );
      },

      data: (user) {
        if (user == null) {
          return const LoginScreen();
        }

        if (!user.emailVerified) {
          return const VerifyEmailScreen();
        }

         return const HomeScreen();
      },
    );
  }
}