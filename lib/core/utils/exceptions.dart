import 'package:firebase_auth/firebase_auth.dart';
import 'logger.dart';

class FirebaseExceptionHandler {
  /// Handles all Firebase Auth related exceptions
  static String handleAuthException(FirebaseAuthException e) {
    log.e('FirebaseAuthException: ${e.code}', error: e);
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'invalid-credential':
        return 'Invalid credentials provided.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'session-expired':
        return 'The verification session has expired. Please try again.';
      case 'requires-recent-login':
        return 'Please log in again before performing this operation.';
      default:
        return 'An unknown authentication error occurred. (${e.code})';
    }
  }

  /// Handles Firestore related exceptions
  static String handleFirestoreException(FirebaseException e) {
    log.e('FirestoreException: ${e.code}', error: e);
    switch (e.code) {
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'not-found':
        return 'The requested document was not found.';
      case 'already-exists':
        return 'This document already exists.';
      case 'permission-denied':
        return 'You do not have permission to access this resource.';
      case 'unavailable':
        return 'Firestore service is currently unavailable. Try again later.';
      case 'deadline-exceeded':
        return 'The request took too long. Please try again.';
      case 'resource-exhausted':
        return 'Quota exceeded. Please try again later.';
      case 'failed-precondition':
        return 'The operation could not be completed due to a failed precondition.';
      case 'data-loss':
        return 'Data loss occurred. Please try again.';
      default:
        return 'An unknown Firestore error occurred. (${e.code})';
    }
  }

  /// Handles Firebase Storage related exceptions
  static String handleStorageException(FirebaseException e) {
    log.e('StorageException: ${e.code}', error: e);
    switch (e.code) {
      case 'object-not-found':
        return 'The requested file does not exist.';
      case 'unauthorized':
        return 'You do not have permission to access this file.';
      case 'cancelled':
        return 'The upload/download was cancelled.';
      case 'quota-exceeded':
        return 'Storage quota exceeded. Please try again later.';
      case 'unauthenticated':
        return 'Please sign in to access this file.';
      default:
        return 'An unknown storage error occurred. (${e.code})';
    }
  }

  /// General catch-all handler (safe to call for any exception)
  static String handleException(Object e) {
    if (e is FirebaseAuthException) {
      return handleAuthException(e);
    }
    if (e is FirebaseException) {
      // Determine if this is Firestore or Storage based on plugin
      if (e.plugin == 'cloud_firestore') {
        return handleFirestoreException(e);
      } else if (e.plugin == 'firebase_storage') {
        return handleStorageException(e);
      }
    }
    log.e('Unknown exception', error: e);
    return 'Unexpected error occurred. Please try again.';
  }
}
