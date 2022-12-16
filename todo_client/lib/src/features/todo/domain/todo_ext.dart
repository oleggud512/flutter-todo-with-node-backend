import 'package:todo_client/src/features/todo/domain/todo.dart';

extension TodoExt on Todo {
  bool exists() => id > 0;
}