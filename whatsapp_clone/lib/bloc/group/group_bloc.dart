import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/group/group_event.dart';
import 'package:whatsapp_clone/bloc/group/group_state.dart';
import 'package:whatsapp_clone/models/group_model.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  FirebaseService firebaseService;
  GroupBloc(this.firebaseService) : super(GroupInitial()) {
    on<CreateGroup>((event, emit) async {
      try {
        await firebaseService.createGroup(event.group);
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<LoadGroup>((event, emit) async {
      try {
        emit(GroupLoading());
        await emit.forEach<List<GroupModel>>(
          firebaseService.getGroup(event.uid),
          onData: (List<GroupModel> group) {
            return GroupLoaded(groups: group);
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
