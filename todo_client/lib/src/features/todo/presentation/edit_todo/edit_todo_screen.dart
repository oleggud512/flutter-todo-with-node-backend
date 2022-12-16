import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_client/src/features/todo/presentation/edit_todo/edit_todo_screen_controller.dart';

import '../../domain/todo.dart';

class EditTodoScreen extends ConsumerWidget {
  EditTodoScreen({super.key, required this.todoId});

  final titleCont = TextEditingController();
  int todoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editTodoScreenControllerProvider(todoId));
    final cont = ref.watch(editTodoScreenControllerProvider(todoId).notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(state.titleText),
        leading: BackButton(onPressed: () { 
          if (state.isEdit) cont.submit(); 
          context.goNamed('todos'); 
        })
      ),
      body: state.todo.when(
        data: (todo) {
          titleCont.text = todo.title;
          return Column(
            children: [
              Checkbox(
                value: state.todo.value!.completed,
                onChanged: (v) {
                  print(ref.read(editTodoScreenControllerProvider(todoId).notifier).dateCreated);
                  cont.completedChanged(v!);
                }
              ),
              TextField(
                controller: titleCont,
                onChanged: (newTitle) {
                  print(cont.dateCreated);
                  cont.titleChanged(newTitle);
                }
              )
            ]
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString()))
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          cont.submit();
          context.goNamed('todos');
        }
      ),
    );
  }
}