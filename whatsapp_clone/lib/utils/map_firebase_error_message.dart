String mapFirebaseErrorToMessage(String errorCode) {
  switch (errorCode) {
    // --- Registration Errors ---
    case 'email-already-in-use':
      return 'This email is already registered. Try logging in instead.';
    case 'operation-not-allowed':
      return 'Email/Password accounts are not enabled. Contact support.';
    case 'weak-password':
      return 'The password provided is too weak.';

    // --- Login / Credential Errors ---
    case 'invalid-email':
      return 'The email address is not formatted correctly.';
    case 'user-disabled':
      return 'This user account has been disabled.';
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      // Security Tip: Use a generic message for all three
      return 'Invalid email or password.';

    // --- Account / Session Errors ---
    case 'too-many-requests':
      return 'Too many failed attempts. Please try again later.';
    case 'network-request-failed':
      return 'No internet connection detected.';
    case 'requires-recent-login':
      return 'Please log in again before sensitive actions (like deleting account).';
    case 'user-token-expired':
      return 'Your session has expired. Please log in again.';

    default:
      return 'An unexpected error occurred ($errorCode).';
  }
}
