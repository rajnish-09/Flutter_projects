import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/models/user_model.dart';

abstract class AuthEvent {}

class SignupEvent extends AuthEvent {
  final UserModel user;
  SignupEvent({required this.user});
}

class LoginEvent extends AuthEvent {
  final String email, password;
  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent{}