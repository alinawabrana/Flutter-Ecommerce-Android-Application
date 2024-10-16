class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase Error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'user-disabled':
        return 'The user account has been disabled';
      case 'user-not-found':
        return 'There is no existing user record corresponding to the provided user detail.';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email';
      case 'wrong-password':
        return 'Invalid Password. Please check your password and try again';
      case 'weak-password':
        return 'The password is too weak. Please use a Strong Password';
      case 'provider-already-linked':
        return 'The account is already linked with another provider';
      case 'operation-not-allowed':
        return 'The Sign-in provider is disabled for your Firebase Project';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired.';
      case 'invalid-verification-code':
        return 'Invalid Verification Code. Please enter a valid Verification Code';
      case 'invalid-verification-id':
        return 'Invalid Verification ID. Please request a new Verification Code';
      case 'captcha-check-failed':
        return 'The reCAPTCHA response is invalid. Please try again.';
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase Authentication with the provided API Key.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check the keychain and try again.';
      case 'internal-error':
        return 'An Internal Authentication Error occurred. Please try again later.';
      case 'invalid-app-credential':
        return 'The app credential is invalid. Please provide a valid app credential.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires a recent authentication. Please login again.';
      case 'quota-exceeded':
        return 'Quota Exceeded. Please try again later';
      case 'account-exist-with-different-credential':
        return 'An account associated with provided credential already exist';
      case 'missing-iframe-start':
        return 'The email template is missing iframe start tag.';
      case 'missing-iframe-end':
        return 'The email template is missing iframe end tag.';
      case 'missing-iframe-src':
        return 'The email template is missing iframe src attribute.';
      case 'auth-domain-config-required':
        return 'The authDomain configuration is required for the action code verification link';
      case 'session-cookie-expired':
        return 'The Firebase session cookie expired. Please sign in again.';
      case 'uid-already-exist':
        return 'The provided User ID is already in use by another user.';
      case 'missing-app-credential':
        return 'The app credential is missing. Please provide valid app credentials.';
      case 'web-storage-unsupported':
        return 'Web Storage is not supported or disabled.';
      case 'app-deleted':
        return 'This instance of Firebase App is deleted.';
      case 'user-token-mismatch':
        return 'The provided user\'s token has a mismatch with the authenticated user\'s user id.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sender\'s email';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please verify the recipient email';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please  sign in again.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account';
      default:
        return 'An unexpected Firebase error has occurred. Please try again.';
    }
  }
}
