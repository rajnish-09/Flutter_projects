import 'package:whatsapp_clone/models/group_model.dart';

abstract class GroupState {}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupCreated extends GroupState {}

class GroupLoaded extends GroupState {
  final List<GroupModel> groups;
  GroupLoaded({required this.groups});
}

class Groupleaved extends GroupState{}