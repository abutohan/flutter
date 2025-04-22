import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "auth_event.dart";
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);

    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final email = event.email;
    final password = event.password;
    try {
      if (password == "admin" && email == "admin") {
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(AuthSucess("$email - $password"));
        });
      } else {
        return emit(AuthFailure("Wrong email and password!"));
      }
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
