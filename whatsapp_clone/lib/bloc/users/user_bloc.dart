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
        throw Exception(e.toString());
      }
    });

    on<GetUser>((event, emit) async {
      try {
        emit(UserLoading());
        final userData = await firebaseService.getUserData();
        emit(LoadPersonalDetail(userData: userData));
      } catch (e) {
        // throw Exception(e.toString());
        print(e.toString());
        emit(UserError(msg: e.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      try {
        await firebaseService.updateUserData(event.userData);
        emit(UserUpdated());
        emit(LoadPersonalDetail(userData: event.userData));
      } catch (e) {
        print(e.toString());
        emit(UserError(msg: e.toString()));
      }
    });
  }
}
