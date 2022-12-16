import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/auth/data/auth_repository.dart';
import 'package:todo_client/src/features/auth/presentation/auth_screen.dart';
import 'package:todo_client/src/features/todo/domain/todo.dart';

import '../features/todo/presentation/edit_todo/edit_todo_screen.dart';
import '../features/todo/presentation/todo_list/todo_list_screen.dart';
import 'go_router_refresh_stream.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  var authRepo = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authRepo.authStateChanges()),
    redirect: (context, state) {
      final isLoggedIn = authRepo.currentUser != null;
      if (isLoggedIn && state.location == '/auth') {
        return '/todos';
      } else if (!isLoggedIn && state.location != '/auth') {
        return '/auth';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'default',
        builder: (context, state) => Scaffold(appBar: AppBar(title: const Text("ROOT ROUTE")))
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder:(context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/todos',
        name: 'todos',
        builder: (context, state) => const TodoListScreen(),
        routes: [
          GoRoute(
            path: ':id',
            name: 'edit-todo',
            builder: (context, state) => EditTodoScreen(todoId: int.parse(state.params["id"] as String))
          )
        ]
      )
    ]
  );
});