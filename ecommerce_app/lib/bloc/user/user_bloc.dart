import 'package:ecommerce_app/bloc/user/user_event.dart';
import 'package:ecommerce_app/bloc/user/user_state.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseService firebaseService = FirebaseService();
  UserBloc() : super(UserInitial()) {
    on<GetUser>((event, emit) async {
      try {
        emit(UserLoading());
        final userData = await firebaseService.getUserData();
        emit(UserLoaded(userData: userData));
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
        emit(UserLoaded(userData: event.userData));
      } catch (e) {
        print(e.toString());
        emit(UserError(msg: e.toString()));
      }
    });
  }
}
