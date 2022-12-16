import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_client/objectbox.g.dart';
import 'package:todo_client/src/app.dart';
import 'package:todo_client/src/features/todo/data/local/todo_local_datasource.dart';
import 'package:todo_client/src/features/todo/data/local/todo_local_datasource_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize local data source
  final todoLocalDataSource = await TodoLocalDataSourceImpl.create();
  final container = ProviderContainer(
    overrides: [
      todoLocalDataSourceProvider.overrideWithValue(todoLocalDataSource)
    ]
  );
  // TODO: sync remote with local data source
  

  runApp(UncontrolledProviderScope(
    container: container, 
    child: const MyApp()
  ));
}