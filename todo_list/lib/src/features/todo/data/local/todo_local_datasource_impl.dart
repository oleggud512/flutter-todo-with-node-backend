import 'package:path_provider/path_provider.dart';
import 'package:todo_list/objectbox.g.dart';
import 'package:todo_list/src/features/todo/data/local/todo_local_datasource.dart';
import 'package:todo_list/src/features/todo/domain/mapper.dart';
import 'package:todo_list/src/features/todo/domain/todo.dart';

class TodoLocalDataSourceImpl extends TodoLocalDataSoruce {

  TodoLocalDataSourceImpl._create(this.store) {
    todosBox = store.box<TodoObject>();
    getAllQuery = todosBox.query().build();
    print("TodoLocalDataSourceImpl created");
  }

  static Future<TodoLocalDataSourceImpl> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = openStore(directory: "${docsDir.path}/default");
    return TodoLocalDataSourceImpl._create(store);
  }

  final Store store;

  late final Box<TodoObject> todosBox;
  late final Query<TodoObject> getAllQuery;

  @override
  Todo addTodo(Todo todo) { // если сюда что-то попадает, то это что-то точно пришло к нам от бэкенда, следовательнь, и id там уже есть уникальный. 
    int id = todosBox.put(todo.toObject());
    return todosBox.get(id)!.toDomain();
  }

  @override
  void addTodos(List<Todo> todos) {
    todosBox.putMany(todos.toObjects());
  }

  @override
  void clearTodos() {
    todosBox.removeAll();
  }

  @override
  void deleteTodo(int id) {
    todosBox.remove(id);
  }

  @override
  Todo? fetchTodo(int id) {
    return todosBox.get(id)?.toDomain();
  }

  @override
  List<Todo> fetchTodos() {
    return todosBox.getAll().toDomain();
  }

  @override
  Todo updateTodo(Todo todo) {
    int id = todosBox.put(todo.toObject(), mode: PutMode.update);
    return todosBox.get(id)!.toDomain();
  }

  @override
  Stream<Todo?> watchTodo(int id) {
    return todosBox.query(TodoObject_.id.equals(id))
      .watch(triggerImmediately: true)
      .map(
        (q) => q.findFirst()?.toDomain()
      );
  }

  @override
  Stream<List<Todo>> watchTodos() {
    return todosBox.query()
      .watch(triggerImmediately: true)
      .map(
        (q) => q.find().toDomain()
      );
  }

}