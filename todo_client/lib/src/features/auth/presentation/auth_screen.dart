import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/features/auth/data/auth_repository.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("AUTH SCREEN")),
      body: Center(
        child: ElevatedButton(
          child: Text('sign in'),
          onPressed: () {
            ref.read(authRepositoryProvider).signIn();
          },
        )
      )
    );
  }
}