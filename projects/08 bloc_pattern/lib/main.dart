import 'package:bloc_pattern/apps/login_app/login_main.dart';
import 'package:bloc_pattern/bloc/auth/auth_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AuthBlocObserver();
  runApp(const LoginMain());
}
