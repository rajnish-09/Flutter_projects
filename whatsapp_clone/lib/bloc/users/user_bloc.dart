import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/users/user_event.dart';
import 'package:whatsapp_clone/bloc/users/user_state.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseService firebaseService;
  UserBloc(this.firebaseService) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      try {
        emit(UserLoading());
        final data = await firebaseService.getUsers();
        emit(UserLoaded(users: data));
      } catch (e) {
        debugPrint("USER FETCH ERROR: $e");
        emit(UserError(msg: e.toString()));
      }
    });
  }
}
