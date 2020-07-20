import 'package:coffee_crew/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthenticationController extends ChangeNotifier {
  final BuildContext buildContext;
  bool showSignIn = true;
  final AuthService _authService = AuthService();

  bool isSignInLoading = false;
  bool isRegistrationLoading = false;
  String registrationErrorMessage = '';
  String signInErrorMessage = '';

  AuthenticationController(this.buildContext);

  void toggleViewRegisterSignIn() {
    showSignIn = !showSignIn;
    notifyListeners();
  }

  set _isRegistrationLoading(bool isLoading) {
    isRegistrationLoading = isLoading;
    notifyListeners();
  }

  set _isSignInLoading(bool isLoading) {
    isSignInLoading = isLoading;
    notifyListeners();
  }

  void onRegisterButtonPressed(String email, String password) async {
    _isRegistrationLoading = true;
    dynamic result =
        await _authService.registerWithEmailAndPasswort(email, password);
    _isRegistrationLoading = false;
    if (result == null) {
      registrationErrorMessage = 'please supply a valid email';
    }
  }

  void onSignInButtonPressed(String email, String password) async {
    _isSignInLoading = true;
    dynamic result =
        await _authService.signInWithEmailAndPasswort(email, password);
    _isSignInLoading = false;
    if (result == null) {
      signInErrorMessage = 'Could not sign in with those credentials';
    }
  }

  // If valid, it returns null
  String validateEmailField(String value) {
    return value.isEmpty ? 'Enter an eMail' : null;
  }

  String validatePasswordField(String value) {
    return value.length < 6 ? 'Enter a Password 6+ chars long' : null;
  }
}
