import 'package:bloc/bloc.dart';
import 'package:task_management/auth/auth_service.dart';
import 'package:task_management/auth/bloc/auth_event.dart';
import 'package:task_management/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    AuthService authService = AuthService();
    on<LoginUserWithEmail>((event, emit) async {
      emit(AuthLoading());
      try {
        final uid = await authService.loginUserWithEmail(
          event.email,
          event.password,
        );
        if (!isClosed) emit(AuthLoginSuccess(uid: uid));
      } catch (e) {
        if (!isClosed) emit(AuthFailure(errorMessage: e.toString()));
      }
    });
  }
}
