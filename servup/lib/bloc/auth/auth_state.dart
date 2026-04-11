abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailed extends AuthState {
  String msg;
  SignupFailed({required this.msg});
}

class LoginSuccess extends AuthState {}

class LoginFailed extends AuthState {
  String msg;
  LoginFailed({required this.msg});
}
