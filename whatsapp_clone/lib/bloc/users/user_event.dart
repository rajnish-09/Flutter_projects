import 'package:whatsapp_clone/models/user_model.dart';

abstract class UserEvent {}

class LoadUsers extends UserEvent{}


class GetUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final UserModel userData;
  UpdateUser({required this.userData});
}
