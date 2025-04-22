import 'package:bloc_pattern/bloc/todo/todo_bloc.dart';
import 'package:bloc_pattern/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final todoTitleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    todoTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: todoTitleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // BlocProvider.of<TodoCubit>(
                //   context,
                // ).addTodo(todoTitleController.text.trim());
                // context.read<TodoCubit>().addTodo(
                //   todoTitleController.text.trim(),
                // );
                context.read<TodoBloc>().add(
                  AddTodo(
                    todo: Todo(
                      name: todoTitleController.text.trim(),
                      createdAt: DateTime.now(),
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
