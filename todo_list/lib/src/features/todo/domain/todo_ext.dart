import 'package:todo_list/src/features/todo/domain/todo.dart';

extension TodoExt on Todo {
  bool exists() => id > 0;
}