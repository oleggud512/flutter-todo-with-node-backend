import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/src/features/todo/domain/todo.dart';

abstract class TodoRemoteDataSource {
  fetchTodos();
  fetchTodo(int id);
  updateTodo(Todo todo);
  deleteTodo(int id);
  Future<Todo> addTodo(Todo todo);
  Future<void> clearTodos();
}

final dioProvider = Provider((ref) {
  return Dio();
});

// final todoRemoteDataSourceProvider = Provider((ref) {
//   return TodoRemoteDataSourceImpl(ref.watch(dioProvider));
// });