import 'package:whatsapp_clone/models/group_model.dart';

abstract class GroupEvent {}

class CreateGroup extends GroupEvent {
  final GroupModel group;
  CreateGroup({required this.group});
}

class LoadGroup extends GroupEvent {
  final String uid;
  LoadGroup({required this.uid});
}

class LeaveGroup extends GroupEvent {
  final String groupId;
  LeaveGroup({required this.groupId});
}
