import 'package:servup/models/user_model.dart';

abstract class AuthEvent {}

class SignupEvent extends AuthEvent {
  UserModel user;
  SignupEvent({required this.user});
}

class LoginEvent extends AuthEvent {
  String email;
  String password;
  LoginEvent({required this.email, required this.password});
}
