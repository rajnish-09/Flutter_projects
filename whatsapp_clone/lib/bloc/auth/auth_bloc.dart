import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/auth/auth_event.dart';
import 'package:whatsapp_clone/bloc/auth/auth_state.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:whatsapp_clone/utils/map_firebase_error_message.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseService firebaseService;
  AuthBloc(this.firebaseService) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.loginUser(event.email, event.password);
        emit(AuthLoginSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthLoginFailed(msg: mapFirebaseErrorToMessage(e.code)));
      } catch (e) {
        emit(AuthLoginFailed(msg: e.toString()));
      }
    });

    on<SignupEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        await firebaseService.createUsers(
          userData: event.userData,
          password: event.password,
        );
        emit(AuthSignupSuccess(msg: 'Signup successfully. Proceed to login.'));
      } on FirebaseAuthException catch (e) {
        emit(AuthSignupFailed(msg: e.toString()));
      } catch (e) {
        emit(AuthSignupFailed(msg: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      try {
        await firebaseService.logoutUser();
        emit(AuthLogoutSuccess());
      } on FirebaseAuthException {
        emit(AuthLoginFailed(msg: 'Failed to logout'));
      } catch (e) {
        AuthLogoutFailed(msg: e.toString());
      }
    });
  }
}
