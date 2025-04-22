import 'package:bloc_pattern/apps/login_app/login_screen.dart';
import 'package:bloc_pattern/apps/login_app/widgets/gradient_button.dart';
import 'package:bloc_pattern/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final authState = context.watch<AuthBloc>().state as AuthSucess;
    //context wath = executes the rebuild everytime the state changes
    //BlocBuilder = only refreshes the widget that needs the UI change
    return Scaffold(
      appBar: AppBar(title: const Text("Successul login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((state as AuthSucess).uid),
                const SizedBox(height: 40),
                GradientButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                  buttonName: 'Sign out',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
