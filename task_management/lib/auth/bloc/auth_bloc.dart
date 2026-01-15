import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/auth/bloc/auth_event.dart';
import 'package:task_management/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService authService;
  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginUserWithEmail>((event, emit) async {
      emit(AuthLoading());
      if (event.email.isEmpty && event.password.isEmpty) {
        emit(AuthFailure(errorMessage: 'All fields are required'));
        return;
      }
      try {
        final uid = await authService.loginUserWithEmail(
          event.email,
          event.password,
        );
        if (!isClosed) emit(AuthLoginSuccess(uid: uid));
      } on FirebaseAuthException catch (e) {
        if (!isClosed) emit(AuthFailure(errorMessage: e.message.toString()));
        // if (!isClosed) emit(AuthFailure(errorMessage: e.toString()));
        // rethrow;
      } catch (e) {
        if (!isClosed) emit(AuthFailure(errorMessage: e.toString()));
      }
    });

    on<LogoutUser>((event, emit) async {
      emit(AuthLoading());
      await authService.logoutUser();
      emit(AuthMessage(message: 'Logged out successfully'));
    });

    on<SignupUserWithEmail>((event, emit) async {
      emit(AuthLoading());
      try {
        if (event.email.isEmpty &&
            event.password.isEmpty &&
            event.name.isEmpty) {
          emit(AuthFailure(errorMessage: 'All fields are required'));
        } else {
          final uid = await authService.signUpWithEmail(
            name: event.name,
            email: event.email,
            password: event.password,
          );
          emit(AuthSignupSuccess(uid: uid));
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(errorMessage: e.message.toString()));
      } catch (e) {
        emit(AuthFailure(errorMessage: e.toString()));
      }
    });
  }
}
