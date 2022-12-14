import 'package:todo_list/src/features/todo/domain/todo.dart';

extension TodoMapper on Todo {
  TodoObject toObject() => TodoObject(
    id: id, 
    completed: completed, 
    title: title
  );
}

extension TodoObjectMapper on TodoObject {
  Todo toDomain() => Todo(
    id: id, 
    completed: completed, 
    title: title
  );
}

extension TodoListMapper on List<Todo> {
  List<TodoObject> toObjects() => map((t) => t.toObject()).toList();
}

extension TodoObjectListMapper on List<TodoObject> {
  List<Todo> toDomain() => map((t) => t.toDomain()).toList();
}