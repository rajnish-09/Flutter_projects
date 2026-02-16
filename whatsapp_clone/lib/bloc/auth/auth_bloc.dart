import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_event.dart';
import 'package:whatsapp_clone/bloc/auth/auth_state.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseService firebaseService;
  AuthBloc(this.firebaseService) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) {});

    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.createUsers(
          userData: event.userData,
          password: event.password,
        );
        emit(AuthSuccess());
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
