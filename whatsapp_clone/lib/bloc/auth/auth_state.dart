abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {}

class AuthSignupSuccess extends AuthState {
  final String msg;
  AuthSignupSuccess({required this.msg});
}

class AuthSignupFailed extends AuthState {
  final String msg;
  AuthSignupFailed({required this.msg});
}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailed extends AuthState {
  final String msg;
  AuthLoginFailed({required this.msg});
}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailed extends AuthState {
  final String msg;
  AuthLogoutFailed({required this.msg});
}

class AccountDeleted extends AuthState{}