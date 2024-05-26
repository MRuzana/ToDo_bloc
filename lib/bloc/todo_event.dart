part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class InitialFetchingEvent extends TodoEvent {}

class AddEvent extends TodoEvent {
  final TodoModel todo;

  AddEvent({required this.todo});
}

class UpdateEvent extends TodoEvent {
  final TodoModel todo;

  UpdateEvent({required this.todo});
}

class DeleteEvent extends TodoEvent {
  final String id;

  DeleteEvent({required this.id});
}
