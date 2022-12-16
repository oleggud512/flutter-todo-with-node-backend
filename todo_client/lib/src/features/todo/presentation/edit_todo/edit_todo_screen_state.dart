import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/todo.dart';

// enum EditTodoScreenType { edit, add }

class EditTodoScreenState {
  EditTodoScreenState({
    required this.todo
  });

  AsyncValue<Todo> todo;

  EditTodoScreenState copyWith({AsyncValue<Todo>? todo}) {
    return EditTodoScreenState(
      todo: todo ?? this.todo,
    );
  }

  bool get isAdd {
    return todo.value!.id == 0;
  }
  bool get isEdit {
    return todo.value!.id > 0;
  }
  
  String get titleText {
    if (todo.value == null) return "Loading";
    if (todo.value!.id > 0) return "Edit Todo";
    return "Add Todo";
  }
}