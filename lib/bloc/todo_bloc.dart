import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/todo_model.dart';
import 'package:task_manager/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo todoRepo;
  TodoBloc(this.todoRepo) : super(TodoInitial()) {
    on<InitialFetchingEvent>(initialFetchingEvent);
    on<AddEvent>(addEvent);
    on<UpdateEvent>(updateEvent);
    on<DeleteEvent>(deleteEvent);
  }

  FutureOr<void> initialFetchingEvent(
      InitialFetchingEvent event, Emitter<TodoState> emit) async {
    emit(LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<TodoModel> todolist = await TodoRepo().getAllTodo();
      emit(SuccessState(todoList: todolist));
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> addEvent(AddEvent event, Emitter<TodoState> emit) async {
    try {
      final statuscode = await TodoRepo().addTodo(event.todo);

      if (statuscode == 201) {
        emit(ResponseState(responseMsg: 'Added successfully'));
      } else {
        emit(ResponseState(responseMsg: 'not Added'));
      }
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> updateEvent(UpdateEvent event, Emitter<TodoState> emit) async {
    try {
      final statuscode = await TodoRepo().updateData(event.todo);

      if (statuscode == 200) {
        emit(ResponseState(responseMsg: 'updated successfully'));
      } else {
        emit(ResponseState(responseMsg: 'not updated'));
      }
    } catch (e) {
      emit(ErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> deleteEvent(DeleteEvent event, Emitter<TodoState> emit) async {
    try {
      // Delete the todo item
      final statusCode = await TodoRepo().deleteToDo(event.id);

      if (statusCode == 200) {
        emit(ResponseState(responseMsg: "Deleted successfully"));
      } else {
        emit(ResponseState(responseMsg: "Unable to delete"));
      }
    } catch (e) {
      emit(ResponseState(responseMsg: e.toString()));
    }
  }
}
