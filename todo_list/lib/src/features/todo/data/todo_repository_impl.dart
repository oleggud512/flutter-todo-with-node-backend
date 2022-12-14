import 'dart:developer';

import 'package:todo_list/src/features/todo/data/local/todo_local_datasource.dart';
import 'package:todo_list/src/features/todo/data/remote/todo_remote_datasource.dart';
import 'package:todo_list/src/features/todo/data/todo_repository.dart';
import 'package:todo_list/src/features/todo/domain/todo.dart';

class TodoRpositoryImpl implements TodoRepository {
  TodoRpositoryImpl({
    required this.local, 
    required this.remote
  });

  TodoLocalDataSoruce local;
  TodoRemoteDataSource remote;
  
  @override
  Future<void> addTodo(Todo todo) async {
    try {
      Todo newTodo = await remote.addTodo(todo);
      await local.addTodo(newTodo);
    } catch (e) {
      log("repoImpl.addTodo", error: e);
      await local.addTodo(todo);
    }
  }

  @override
  Future<void> clearTodos() async {
    try {
      await remote.clearTodos();
      await local.clearTodos();
    } catch (e) {
      log("repoImpl.clearTodos", error: e);
      await local.clearTodos();
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try { // TODO: по идее, тут вообще не нужен try/catch
      await remote.deleteTodo(id);
      await local.deleteTodo(id);
    } catch (e) {
      await local.deleteTodo(id);
    }
  }

  @override
  Future<Todo?> fetchTodo(int id) async {
    try {
      Todo newTodo = await remote.fetchTodo(id);
      await local.updateTodo(newTodo);
      return newTodo;
    } catch (e) {
      log("repoImpl.fetchTodo", error: e);
      return local.fetchTodo(id);
    }
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    try {
      List<Todo> todos = await remote.fetchTodos();
      await local.clearTodos();
      await local.addTodos(todos);
      return todos;
    } catch (e) {
      log("repoImpl.fetchTodos", error: e);
      return local.fetchTodos();
    }
  }

  @override
  Future<Todo?> updateTodo(Todo todo) async {
    try {
      Todo newTodo =  await remote.updateTodo(todo);
      return await local.updateTodo(newTodo);
    } catch (e) {
      log("repoImpl.updateTodo", error: e);
      return await local.updateTodo(todo);
    }
  }

  @override
  Stream<Todo?> watchTodo(int id) {
    // TODO: implement watchTodo
    throw UnimplementedError();
  }

  @override
  Stream<List<Todo>> watchTodos() {
    // TODO: implement watchTodos
    throw UnimplementedError();
  }

}