part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSucess extends AuthState {
  final String uid; //usermodel

  AuthSucess(this.uid);
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure(this.errorMessage);
}

final class AuthLoading extends AuthState {}
