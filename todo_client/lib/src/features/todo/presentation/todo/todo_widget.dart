import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/todo/domain/todo.dart';

import '../../data/synchronized/todo_repository.dart';

class TodoWidget extends ConsumerWidget {
  TodoWidget({super.key, required this.todoId});

  int todoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoStreamProvider(todoId));
    return todo.when(
      data: (data) => data != null 
        ? InkWell(
          onTap: () {
            context.goNamed("edit-todo", params: {"id": todoId.toString()});
          },
          child: Row(
            children: [
              Checkbox(
                value: data.completed,
                onChanged: (newCompleted) {
                  ref.watch(todoRepositoryProvider)
                    .updateTodo(data.copyWith(completed: newCompleted!));
                }
              ),
              Text(data.title)
            ]
          )
        ) 
        : Text("no todo with id $todoId"),
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}