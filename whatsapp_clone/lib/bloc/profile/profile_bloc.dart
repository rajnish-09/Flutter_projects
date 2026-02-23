import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/profile/profile_event.dart';
import 'package:whatsapp_clone/bloc/profile/profile_state.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  FirebaseService firebaseService;
  ProfileBloc(this.firebaseService) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        final user = await firebaseService.getPersonalDetail();
        emit(LoadPersonalDetail(userData: user));
      } catch (e) {
        // throw Exception(e.toString());
        print(e.toString());
        emit(ProfileError(msg: e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      try {
        await firebaseService.updateUserData(event.userData);
        emit(ProfileUpdated());
        emit(LoadPersonalDetail(userData: event.userData));
      } catch (e) {
        print(e.toString());
        emit(ProfileError(msg: e.toString()));
      }
    });
  }
}
