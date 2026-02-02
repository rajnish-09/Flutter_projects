import 'package:ecommerce_app/bloc/auth/auth_event.dart';
import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseService firebaseService = FirebaseService();
  AuthBloc() : super(AuthInitial()) {
    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.createUsers(userData: event.user);
        emit(SignupSuccess(msg: 'Signup success. Please proceed to login'));
      } catch (e) {
        emit(SignupFailed(msg: 'Error during signup. Please try again.'));
      }
    });

    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.loginUser(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess(msg: 'Successfully logged in'));
      } catch (e) {
        emit(LoginFailed(msg: 'Error during login'));
      }
    });
  }
}
