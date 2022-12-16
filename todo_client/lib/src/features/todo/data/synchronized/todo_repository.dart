import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/src/features/todo/data/fake_todo_impl.dart';
import 'package:todo_client/src/features/todo/data/local/todo_local_datasource.dart';
import 'package:todo_client/src/features/todo/data/remote/todo_remote_datasource.dart';
import 'package:todo_client/src/features/todo/data/synchronized/todo_repository_impl.dart';

import '../../domain/todo.dart';

abstract class TodoRepository {

  Future<List<Todo>> fetchTodos();
  Future<Todo?> fetchTodo(int id);
  Stream<List<Todo>> watchTodos();
  Stream<Todo?> watchTodo(int id);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
  // Future<Todo?> addTodo(Todo todo);
  Future<void> addTodo(Todo todo);
  Future<void> clearTodos();
}

// final todoRepositoryProvider = Provider((ref) {
//   return FakeTodoRepositoryImpl();
// });

final todoRepositoryProvider = Provider((ref) {
  return TodoRepositoryImpl(
    local: ref.watch(todoLocalDataSourceProvider),
    remote: ref.watch(todoRemoteDataSourceProvider)
  );
});

final todosStreamProvider = StreamProvider((ref) {
  return ref.watch(todoRepositoryProvider).watchTodos();
});

final todoStreamProvider = StreamProvider.autoDispose.family<Todo?, int>((ref, id) {
  return ref.watch(todoRepositoryProvider).watchTodo(id);
});