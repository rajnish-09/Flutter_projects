import 'package:whatsapp_clone/models/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class LoadPersonalDetail extends ProfileState {
  final UserModel userData;
  LoadPersonalDetail({required this.userData});
}

class ProfileUpdated extends ProfileState {}

class ProfileError extends ProfileState {
  final String msg;
  ProfileError({required this.msg});
}
