part of "todo_bloc.dart";

sealed class TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo({required this.todo});
}
