import 'package:whatsapp_clone/models/user_model.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class SignupEvent extends AuthEvent {
  final UserModel userData;
  final String password;
  SignupEvent({required this.userData,required this.password});
}
