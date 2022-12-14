import 'package:dio/dio.dart';
import 'package:todo_list/src/features/todo/data/remote/todo_remote_datasource.dart';
import 'package:todo_list/src/features/todo/domain/todo.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl({required this.dio});
  
  Dio dio;
  
  @override
  Future<Todo> addTodo(Todo todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  clearTodos() {
    // TODO: implement clearTodos
    throw UnimplementedError();
  }

  @override
  deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  fetchTodo(int id) {
    // TODO: implement fetchTodo
    throw UnimplementedError();
  }

  @override
  fetchTodos() {
    // TODO: implement fetchTodos
    throw UnimplementedError();
  }

  @override
  updateTodo(Todo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

}