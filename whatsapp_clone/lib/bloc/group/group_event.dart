import 'package:whatsapp_clone/models/group_model.dart';

abstract class GroupEvent {}

class CreateGroup extends GroupEvent {
  final GroupModel group;
  CreateGroup({required this.group});
}
