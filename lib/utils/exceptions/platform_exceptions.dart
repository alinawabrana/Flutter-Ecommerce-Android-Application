class TPlatformExceptions implements Exception {
  final String code;

  TPlatformExceptions(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'INVALID_EMAIL':
        return 'Invalid email entered. Please enter a valid email address';
      case 'USER_NOT_FOUND':
        return 'The user is not found. Please enter valid user detail.';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email';
      case 'account-exist-with-different-credential':
        return 'An account associated with provided credential already exist';
      case 'too-many-request':
        return 'Too many request. Please try again later.';
      case 'user-disabled':
        return 'The user account has been disabled';
      case 'invalid-password':
        return 'Invalid password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid';
      case 'operation-not-allowed':
        return 'The Sign-in provider is disabled for your Firebase Project';
      case 'session-cookie-expired':
        return 'The Firebase session cookie expired. Please sign in again.';
      case 'uid-already-exist':
        return 'The provided User ID is already in use by another user.';
      case 'sign_in_failed':
        return 'Sign-In Failed. Please try again.';
      case 'network-request-failed':
        return 'Network Request Failed. Please check your internet connection.';
      case 'internal-error':
        return 'Internal Error. Please try again later.';
      case 'invalid-verification-code':
        return 'Invalid Verification Code. Please enter a valid Verification Code';
      case 'invalid-verification-id':
        return 'Invalid Verification ID. Please request a new Verification Code';
      case 'invalid-argument':
        return 'Invalid arguments provided to the authentication method.';
      default:
        return 'An unexpected Platform error has occurred. Please try again';
    }
  }
}
