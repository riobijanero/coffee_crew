import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_controller.dart';
import 'register_page.dart';
import 'sign_in_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationController>(
        builder: (context, _authenticationController, child) {
      return _authenticationController.showSignIn
          ? SignInPage()
          : RegisterPage();
    });
  }
}
