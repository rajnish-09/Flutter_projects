import 'package:ecommerce_app/models/user_model.dart';

abstract class AuthEvent {}

class SignupEvent extends AuthEvent {
  final UserModel user;
  SignupEvent({required this.user});
}
