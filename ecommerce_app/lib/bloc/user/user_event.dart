import 'package:ecommerce_app/models/user_model.dart';

abstract class UserEvent {}

class GetUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final UserModel userData;
  UpdateUser({required this.userData});
}
