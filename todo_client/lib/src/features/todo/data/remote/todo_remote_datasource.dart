import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/features/todo/data/remote/todo_remote_datasource_impl.dart';
import 'package:todo_client/src/features/todo/domain/todo.dart';
import 'package:todo_client/src/shared/api_source.dart';

/// see also [TodoRemoteDataSourceImpl]
abstract class TodoRemoteDataSource {
  Future<List<Todo>> fetchTodos();
  Future<Todo?> fetchTodo(int id);
  Future<Todo?> updateTodo(Todo todo);
  Future<dynamic> deleteTodo(int id);
  Future<Todo?> addTodo(Todo todo);
  Future<void> clearTodos();
}

final todoRemoteDataSourceProvider = Provider((ref) {
  return TodoRemoteDataSourceImpl(base: ref.watch(baseApiSourceProvider));
});