import 'dart:math';

import 'package:rxdart/subjects.dart';
import 'package:todo_client/src/features/todo/data/synchronized/todo_repository.dart';
import 'package:todo_client/src/features/todo/domain/todo.dart';

extension TodoListExt on List<Todo> {
  int nextId() {
    return map((t) => t.id).reduce(max) + 1;
  }
}

class FakeTodoRepositoryImpl implements TodoRepository {
  final BehaviorSubject<List<Todo>> _v = BehaviorSubject.seeded(
    [
      Todo(id: 1, completed: true, title: "first todo"), 
      Todo(id: 2, completed: false, title: "second todo")
    ]
  );
  @override
  Future<void> sync() async {

  }
  @override
  Future<void> addTodo(Todo todo) {
    if (_v.value.where((t) => t.id == todo.id).isEmpty) {
      _v.add(_v.value..add(todo.copyWith(id: _v.value.nextId())));
    }
    return Future.delayed(const Duration(milliseconds: 700), () {});
  }

  @override
  Future<void> deleteTodo(int id) {
    _v.add(_v.value..removeWhere((t) => t.id == id));
    return Future.delayed(const Duration(milliseconds: 700), () {});
  }

  @override
  Future<Todo?> fetchTodo(int id) {
    return Future.delayed(const Duration(milliseconds: 700), 
      () {
        try {
          return _v.value.firstWhere((t) => t.id == id);
        } catch (e) {
          return null;
        }
      });
  }

  @override
  Future<List<Todo>> fetchTodos() {
    return Future.delayed(const Duration(milliseconds: 700), () => _v.value);
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return Future.delayed(const Duration(milliseconds: 700), () {
      int i = _v.value.indexWhere((t) => t.id == todo.id);
      _v.value.removeAt(i);
      _v.add(_v.value..insert(i, todo));
    });
  }

  @override
  Stream<Todo?> watchTodo(int id) {
    return _v.stream.map((lt) => lt.firstWhere((t) => t.id == id));
  }

  @override
  Stream<List<Todo>> watchTodos() {
    return _v.stream;
  }
  
  @override
  Future<void> clearTodos() {
    return Future.delayed(const Duration(milliseconds: 700), () => _v.add(_v.value..clear()));
  }

}