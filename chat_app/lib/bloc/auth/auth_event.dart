abstract class AuthEvent {}

class SendOtpEvent extends AuthEvent{}

class OtpSentEvent extends AuthEvent{}

class VerifyOtpEvent extends AuthEvent{}

class SignupSuccessEvent extends AuthEvent{}

class SignupFailedEvent extends AuthEvent{}
