import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/viemodel/auth_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final authState = ref.watch(authViewModelProvider);

    final user = authState.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Collection'),
        actions: [
          IconButton(
            onPressed: () async {
              await ref
                  .read(authViewModelProvider.notifier)
                  .logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.child_care,
              size: 100,
            ),

            const SizedBox(height: 25),

            const Text(
              'Welcome to Baby Collection!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            if (user?.email != null)
              Text(
                user!.email!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () async {
                await ref
                    .read(
                  authViewModelProvider.notifier,
                )
                    .logout();
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}