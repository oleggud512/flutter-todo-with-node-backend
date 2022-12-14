import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/todo.dart';

abstract class TodoLocalDataSoruce {
  List<Todo> fetchTodos();
  watchTodos();
  Todo? fetchTodo(int id);
  watchTodo(int id);
  Todo updateTodo(Todo todo);
  void deleteTodo(int id);
  Todo addTodo(Todo todo);
  void addTodos(List<Todo> todos);
  void clearTodos();
}


final todoLocalDataSourceProvider = Provider<TodoLocalDataSoruce>((ref) {
  throw UnimplementedError();
});