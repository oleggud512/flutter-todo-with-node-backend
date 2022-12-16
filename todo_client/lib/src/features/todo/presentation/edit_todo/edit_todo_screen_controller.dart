import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/features/todo/domain/todo_ext.dart';

import '../../data/synchronized/todo_repository.dart';
import '../../domain/todo.dart';
import 'edit_todo_screen_state.dart';

class EditTodoScreenController extends StateNotifier<EditTodoScreenState> {
  EditTodoScreenController({
    required int todoId, 
    required TodoRepository repo
  }) 
    : _repo = repo, 
      dateCreated = DateTime.now(),
      super(EditTodoScreenState(todo: const AsyncValue.loading())) {
    if (todoId > 0) {
      _repo.fetchTodo(todoId).then(
        (todo) {
          state = state.copyWith(todo: AsyncData(todo ?? Todo()));
        }
      );
    } else {
      state = state.copyWith(todo: AsyncData(Todo()));
    }
  }

  TodoRepository _repo;

  DateTime dateCreated;

  void submit() {
    print("submit() - state.isAdd ${state.isAdd}");
    if (state.isAdd) {
      _repo.addTodo(state.todo.value!);
    } else {
      _repo.updateTodo(state.todo.value!);
    }
  }

  void completedChanged(bool newCompleted) {
    state = state.copyWith(todo: AsyncData(state.todo.value!.copyWith(completed: newCompleted)));
  }

  void titleChanged(String newTitle) {
    state.todo = AsyncData(state.todo.value!.copyWith(title: newTitle));
  }

}

final editTodoScreenControllerProvider = StateNotifierProvider.autoDispose
    .family<
      EditTodoScreenController, 
      EditTodoScreenState, 
      int>((ref, todoId) {
  return EditTodoScreenController(
    todoId: todoId, 
    repo: ref.watch(todoRepositoryProvider)
  );
});