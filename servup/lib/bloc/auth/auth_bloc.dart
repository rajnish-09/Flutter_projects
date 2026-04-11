import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servup/bloc/auth/auth_event.dart';
import 'package:servup/bloc/auth/auth_state.dart';
import 'package:servup/services/firebase_service.dart';
import 'package:servup/utils/firebase_auth_errors.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseService firebaseService;
  AuthBloc(this.firebaseService) : super(AuthInitial()) {
    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.signupUsers(event.user);
        emit(SignupSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignupFailed(msg: FirebaseAuthErrors.getMessage(e, isSignup: true)));
      } catch (e) {
        emit(SignupFailed(msg: 'Error during signup. Please try again.'));
      }
    });

    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.loginUsers(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        emit(LoginFailed(msg: FirebaseAuthErrors.getMessage(e)));
      } catch (e) {
        emit(LoginFailed(msg: 'Error during login. Please try again.'));
      }
    });
  }
}
