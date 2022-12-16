import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    @Default(0) @JsonKey(ignore: true) int id,
    @Default(false) bool completed,
    @Default("") String title,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

@Entity()
class TodoObject {
  @Id(assignable: true) int id;
  @Property() bool completed;
  @Property() String title;

  TodoObject({
    required this.id,
    required this.completed,
    required this.title
  });
}