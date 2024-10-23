class TFirebaseAuthException implements Exception {
  /// The error code associated with the exception
  final String code;

  TFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email';
      case 'email-already-exists':
        return 'The provided email is already in use. Please use a different email.';
      case 'user-not-found':
        return 'There is no existing user record corresponding to the provided user detail.';
      case 'too-many-requests':
        return 'Too many request. Please try again later.';
      case 'phone-number-already-exists':
        return 'The provided Phone Number already exist. Please use a different Phone Number';
      case 'operation-not-allowed':
        return 'The provided sign-in provider is disabled for your Firebase project. Enable it from the Sign-in Method section of the Firebase console.';
      case 'invalid-uid':
        return 'The provided uid must be a non-empty string with at most 128 characters.';
      case 'invalid-password':
        return 'Invalid password. Please try again.';
      case 'wrong-password':
        return 'Invalid Password. Please check your password and try again';
      case 'weak-password':
        return 'The password is too weak. Please use a Strong Password';
      case 'user-disabled':
        return 'The user account has been disabled';
      case 'invalid-verification-code':
        return 'Invalid Verification Code. Please enter a valid Verification Code';
      case 'invalid-verification-id':
        return 'Invalid Verification ID. Please request a new Verification Code';
      case 'quota-exceeded':
        return 'Quota Exceeded. Please try again later';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires a recent authentication. Please login again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please try again with valid email address.';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'missing-iframe-start':
        return 'The email template is missing iframe start tag.';
      case 'missing-iframe-end':
        return 'The email template is missing iframe end tag.';
      case 'missing-iframe-src':
        return 'The email template is missing iframe src attribute.';
      default:
        return 'An unexpected FirebaseAuth error has occurred. Please try again';
    }
  }
}
