import 'package:flutter/services.dart';

class FirebaseException{

  static String generateReadableMessage(PlatformException exception) {

    String errorMessage;
    switch (exception.code) {
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "Email not registered";
        break;
      case "Document not found":
        errorMessage = "Not found in our database";
        break;
      case "ERROR_INVALID_EMAIL":
        errorMessage = "Invalid email";
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Your password is wrong.";
        break;
      case "ERROR_WEAK_PASSWORD":
        errorMessage = "Password should be at least 6 characters.";
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "Email is disabled";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Too many requests, try again later";
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        errorMessage = "Email already exists, login instead";
        break;
      case "ERROR_NETWORK_REQUEST_FAILED":
      case "Error performing get":
        errorMessage = "Network problem, check your connection";
        break;
      default:
        errorMessage = "An undefined error happened";
    }
    return errorMessage;
  }
}
