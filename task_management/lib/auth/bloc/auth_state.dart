abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignupSuccess extends AuthState {
  final String uid;
  AuthSignupSuccess({required this.uid});
}

class AuthLoginSuccess extends AuthState {
  final String uid;
  AuthLoginSuccess({required this.uid});
}

class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}

class AuthMessage extends AuthState{
  final String message;
  AuthMessage({required this.message});
}
