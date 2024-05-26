import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:task_manager/todo_model.dart';

class TodoRepo{


  Future<List<TodoModel>>getAllTodo()async{

    try{
      final response = await http.get(Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10'));
      final decodedData = json.decode(response.body)['items'] as List;
      return decodedData.map((todo) => TodoModel.fromJson(todo)).toList();

    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<int>addTodo(TodoModel todo)async{

    
       String title =todo.title;
    String description = todo.description;

     final body = {
      'title': title,
      'description': description,
      'is_completed': false
    };

    final response = await http.post(Uri.parse('https://api.nstack.in/v1/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body)
    );
    return response.statusCode;
    
    }
   
  Future<int> updateData(TodoModel todo)async{

    String title = todo.title;
    String description = todo.description;
    String id = todo.id!;

    final body = {
      'title': title,
      'description': description,
      '_id':id,
      'is_completed': false
    };
    final response = await http.put(
        Uri.parse('https://api.nstack.in/v1/todos/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));

        return response.statusCode;
  }

  Future<int>deleteToDo(String id)async{
    
    final response = await http.delete(Uri.parse('https://api.nstack.in/v1/todos/$id'));
    return response.statusCode;
   
  }
}