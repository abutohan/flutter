import 'package:bloc_pattern/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  TodoBloc() : super([]) {
    on<AddTodo>((event, emit) {
      emit([...state, event.todo]);
    });
  }
}
