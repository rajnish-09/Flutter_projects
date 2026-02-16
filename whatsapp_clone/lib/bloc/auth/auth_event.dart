import 'package:whatsapp_clone/models/user_model.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email, password;
  LoginEvent({required this.email, required this.password});
}

class SignupEvent extends AuthEvent {
  final UserModel userData;
  final String password;
  SignupEvent({required this.userData, required this.password});
}
