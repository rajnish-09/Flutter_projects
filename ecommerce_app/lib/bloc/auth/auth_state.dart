abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignupSuccess extends AuthState {
  final String msg;
  SignupSuccess({required this.msg});
}

class SignupFailed extends AuthState {
  final String msg;
  SignupFailed({required this.msg});
}

class LoginSuccess extends AuthState {
  final String msg;
  LoginSuccess({required this.msg});
}

class LoginFailed extends AuthState {
  final String msg;
  LoginFailed({required this.msg});
}

class LogoutSuccess extends AuthState{}
