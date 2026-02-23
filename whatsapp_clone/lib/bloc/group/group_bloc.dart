import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/group/group_event.dart';
import 'package:whatsapp_clone/bloc/group/group_state.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  FirebaseService firebaseService;
  GroupBloc(this.firebaseService) : super(GroupInitial()) {
    on<CreateGroup>((event, emit) async {
      try {
        await firebaseService.createGroup(event.group);
        emit(GroupCreated());
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
