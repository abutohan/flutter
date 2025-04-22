import 'package:bloc_pattern/apps/login_app/home_screen.dart';
import 'package:bloc_pattern/apps/login_app/widgets/gradient_button.dart';
import 'package:bloc_pattern/apps/login_app/widgets/login_field.dart';
import 'package:bloc_pattern/apps/login_app/widgets/social_button.dart';
import 'package:bloc_pattern/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        //BlockListner =
        //blockConsumer = Block listener + block builder
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state is AuthSucess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Sign in.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                  const SizedBox(height: 50),
                  const SocialButton(
                    iconPath: 'assets/svgs/g_logo.svg',
                    label: 'Continue with Google',
                  ),
                  const SizedBox(height: 20),
                  const SocialButton(
                    iconPath: 'assets/svgs/f_logo.svg',
                    label: 'Continue with Facebook',
                    horizontalPadding: 90,
                  ),
                  const SizedBox(height: 15),
                  const Text('or', style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 15),
                  LoginField(hintText: 'Email', controller: emailController),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    buttonName: "Sign in",
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        AuthLoginRequested(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
