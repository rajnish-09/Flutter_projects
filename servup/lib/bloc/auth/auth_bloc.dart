import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servup/bloc/auth/auth_event.dart';
import 'package:servup/bloc/auth/auth_state.dart';
import 'package:servup/services/firebase_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseService firebaseService;
  AuthBloc(this.firebaseService) : super(AuthInitial()) {
    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.signupUsers(event.user);
        emit(SignupSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignupFailed(msg: e.toString()));
      } catch (e) {
        emit(SignupFailed(msg: 'Error during signup. Please try again.'));
      }
    });
  }
}
