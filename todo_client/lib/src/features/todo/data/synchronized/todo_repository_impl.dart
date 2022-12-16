import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_client/src/features/todo/data/local/todo_local_datasource.dart';
import 'package:todo_client/src/features/todo/data/remote/todo_remote_datasource.dart';
import 'package:todo_client/src/features/todo/data/synchronized/todo_repository.dart';
import 'package:todo_client/src/features/todo/domain/todo.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({
    required this.local, 
    required this.remote
  });

  TodoLocalDataSoruce local;
  TodoRemoteDataSource remote;
  
  @override
  Future<void> addTodo(Todo todo) async {
    try {
      Todo? newTodo = await remote.addTodo(todo);
      if (newTodo != null) local.addTodo(newTodo);
    } catch (e) {
      print("repoImpl.addTodo$e");
      local.addTodo(todo);
    }
  }

  @override
  Future<void> clearTodos() async {
    try {
      await remote.clearTodos();
      local.clearTodos();
    } catch (e) {
      print("repoImpl.clearTodos$e");
      local.clearTodos();
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try { // TODO: по идее, тут вообще не нужен try/catch
      await remote.deleteTodo(id);
      local.deleteTodo(id);
    } catch (e) {
      local.deleteTodo(id);
    }
  }

  @override
  Future<Todo?> fetchTodo(int id) async {
    try {
      Todo? newTodo = await remote.fetchTodo(id);
      if (newTodo != null) local.updateTodo(newTodo);
      return newTodo;
    } catch (e) {
      print("repoImpl.fetchTodo$e");
      return local.fetchTodo(id);
    }
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    try {
      List<Todo> todos = await remote.fetchTodos();
      local.clearTodos();
      local.addTodos(todos);
      return todos;
    } catch (e) {
      print("repoImpl.fetchTodos$e");
      return local.fetchTodos();
    }
  }

  @override
  Future<Todo?> updateTodo(Todo todo) async {
    try {
      Todo? newTodo =  await remote.updateTodo(todo);
      if (newTodo != null) local.updateTodo(newTodo);
      return newTodo;
    } catch (e) {
      return local.updateTodo(todo);
    }
  }

  @override
  Stream<Todo?> watchTodo(int id) {
    return local.watchTodo(id);
  }

  @override
  Stream<List<Todo>> watchTodos() {
    return local.watchTodos();
  }

}