import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/src/features/auth/data/auth_repository.dart';
import 'package:todo_list/src/features/todo/data/todo_repository.dart';
import 'package:todo_list/src/features/todo/presentation/todo/todo_widget.dart';

import '../../domain/todo.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO LIST"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
            }
          )
        ]
      ), 
      body: todos.when(
        data: (todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoWidget(todoId: todos[index].id);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString()))
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.goNamed("edit-todo", params: {'id': "0"});
        }
      ),
    );
  }
}