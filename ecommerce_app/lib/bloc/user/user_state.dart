import 'package:ecommerce_app/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel userData;
  UserLoaded({required this.userData});
}

class UserError extends UserState {
  final String msg;
  UserError({required this.msg});
}
