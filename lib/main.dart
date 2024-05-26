import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/todo_bloc.dart';
import 'package:task_manager/task_page.dart';
import 'package:task_manager/todo_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepo(),
      child: BlocProvider(
        create: (context) =>
            TodoBloc(context.read<TodoRepo>())..add(InitialFetchingEvent()),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                fontSize: 20,

                // backgroundColor: Colors.transparent
              )),
              //  scaffoldBackgroundColor: const Color.fromARGB(255, 211, 204, 204),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: TaskPage()),
      ),
    );
  }
}
