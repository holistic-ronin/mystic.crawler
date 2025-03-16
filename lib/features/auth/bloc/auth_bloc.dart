import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate successful login for demo purposes
      if (event.username.isNotEmpty && event.password.isNotEmpty) {
        emit(state.copyWith(status: AuthStatus.success));
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        error: error.toString(),
      ));
    }
  }
} 