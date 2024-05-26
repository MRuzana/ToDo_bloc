import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/todo_bloc.dart';
import 'package:task_manager/todo_add.dart';
import 'package:task_manager/todo_repo.dart';

class widgetListView extends StatelessWidget {
  final SuccessState state;
  const widgetListView({
    super.key, required this.state,
  });

  @override
  Widget build(BuildContext context) {
   
    return Visibility(
        visible: state.todoList.isNotEmpty,
      replacement: const Center(child: Text("No Todo available"),),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(state.todoList[index].title),
              subtitle: Text(state.todoList[index].description),
              trailing: Column(
                children: [
                  Expanded(child: IconButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodoAdd(todoList: state.todoList[index],)));
      
                  }, icon: const Icon(Icons.edit))),
                  Expanded(child: IconButton(onPressed: (){
      
                  
                    context.read<TodoBloc>().add(DeleteEvent(id: state.todoList[index].id!));
                    context.read<TodoBloc>().add(InitialFetchingEvent());
      
                  }, icon: const Icon(Icons.delete))),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>const  Divider(),
          itemCount: state.todoList.length),
    );
  }
}
