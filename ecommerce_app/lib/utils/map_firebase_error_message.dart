String mapFirebaseErrorToMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'user-disabled':
      return 'This user account has been disabled.';
    case 'user-not-found':
      return 'No account found with this email.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'invalid-credential':
      return 'Invalid email or password.';
    case 'network-request-failed':
      return 'Please check your internet connection.';
    default:
      return 'An unexpected error occurred. Please try later.';
  }
}