abstract class AuthEvent {}

class SignupUserWithEmail extends AuthEvent {
  final String name;
  final String email;
  final String password;
  SignupUserWithEmail({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginUserWithEmail extends AuthEvent {
  final String email, password;
  LoginUserWithEmail({required this.email, required this.password});
}
