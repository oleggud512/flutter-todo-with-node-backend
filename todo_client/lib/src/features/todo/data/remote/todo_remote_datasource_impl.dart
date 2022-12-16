import 'package:dio/dio.dart';
import 'package:todo_client/src/features/todo/data/remote/todo_remote_datasource.dart';
import 'package:todo_client/src/features/todo/domain/todo.dart';
import 'package:todo_client/src/shared/api_source.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl({required this.base}); // на самом деле, это можно
  // сделать и наследованием, и пихать сюда параметром token(). 
  // TODO: но... какая вообще разница?
  
  BaseApiSource base;

  @override
  Future<Todo?> addTodo(Todo todo) async {
    var resp = await base.post("todos", data: todo.toJson());
    return resp.data['data'];
  }

  @override
  clearTodos() {
    // TODO: implement clearTodos
    throw UnimplementedError();
  }

  @override
  deleteTodo(int id) async {
    var resp = await base.delete("todos/$id");
    return resp.data['data'];
  }

  @override
  Future<Todo?> fetchTodo(int id) async {
    var resp = await base.get("todos/$id");
    return Todo.fromJson(resp.data['data']);
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    var resp = await base.get("todos");
    return List<Todo>.from(resp.data['data'])
      .map((elem) => Todo.fromJson(elem as Map<String, dynamic>))
      .toList();
  }

  @override
  Future<Todo?> updateTodo(Todo todo) async {
    var resp = await base.patch("todos/${todo.id}", data: todo.toJson());
    return Todo.fromJson(resp.data['data']);
  }

}