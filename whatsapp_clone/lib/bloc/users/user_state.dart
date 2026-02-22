import 'package:whatsapp_clone/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  UserLoaded({required this.users});
}

class LoadPersonalDetail extends UserState {
  final UserModel userData;
  LoadPersonalDetail({required this.userData});
}

class UserUpdated extends UserState {}

class UserError extends UserState {
  final String msg;
  UserError({required this.msg});
}
