import 'package:bloc_pattern/bloc/todo/todo_bloc.dart';
import 'package:bloc_pattern/cubit/todo/todo_cubit.dart';
import 'package:bloc_pattern/apps/todo_app/add_todo_page.dart';
import 'package:bloc_pattern/apps/todo_app/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoMain extends StatelessWidget {
  const TodoMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoCubit()),
        BlocProvider(create: (context) => TodoBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const TodoList(),
          '/add-todo': (_) => const AddTodoPage(),
        },
      ),
    );
  }
}
