import 'package:whatsapp_clone/models/user_model.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent{}

class UpdateProfile extends ProfileEvent {
  final UserModel userData;
  UpdateProfile({required this.userData});
}
