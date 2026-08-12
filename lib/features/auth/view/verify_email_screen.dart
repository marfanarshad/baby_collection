import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viemodel/auth_view_model.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState
    extends ConsumerState<VerifyEmailScreen> {
  Future<void> _resendEmail() async {
    await ref
        .read(authViewModelProvider.notifier)
        .sendEmailVerification();

    if (!mounted) return;

    final state = ref.read(authViewModelProvider);

    state.whenOrNull(
      data: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Verification email sent.',
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error
                  .toString()
                  .replaceFirst('Exception: ', ''),
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkVerification() async {
    await ref
        .read(authViewModelProvider.notifier)
        .reloadUser();

    if (!mounted) return;

    final state = ref.read(authViewModelProvider);

    state.whenOrNull(
      data: (user) {
        if (user?.emailVerified == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Email verified successfully!',
              ),
            ),
          );

          // AuthGate will eventually show Home.
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Email is not verified yet.',
              ),
            ),
          );
        }
      },
      error: (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error
                  .toString()
                  .replaceFirst('Exception: ', ''),
            ),
          ),
        );
      },
    );
  }

  Future<void> _logout() async {
    await ref
        .read(authViewModelProvider.notifier)
        .logout();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 90,
              ),

              const SizedBox(height: 30),

              const Text(
                'Verify Your Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'We have sent a verification link to your '
                    'email address. Please check your inbox '
                    'and click the verification link.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : _checkVerification,
                  child: state.isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child:
                    CircularProgressIndicator(),
                  )
                      : const Text(
                    "I've Verified My Email",
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed:
                  state.isLoading ? null : _resendEmail,
                  child: const Text(
                    'Resend Verification Email',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: state.isLoading
                    ? null
                    : _logout,
                child: const Text(
                  'Logout',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}