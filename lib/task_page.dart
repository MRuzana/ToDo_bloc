import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/todo_bloc.dart';
import 'package:task_manager/todo_add.dart';
import 'package:task_manager/todo_model.dart';
import 'package:task_manager/widget_listview.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  late Future<List<TodoModel>> todolist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is ResponseState) {
             ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.responseMsg)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessState) {
            return widgetListView(state: state);
          } else if (state is ErrorState) {
            return Text(state.errorMsg);
          } else {
            return const SizedBox();
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoAdd()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
