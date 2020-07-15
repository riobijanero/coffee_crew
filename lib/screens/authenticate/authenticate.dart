import 'package:coffee_crew/screens/authenticate/register.dart';
import 'package:coffee_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleViewRegisterSignIn() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleViewToRegister: toggleViewRegisterSignIn);
    }
    return Register(toggleViewToSignIn: toggleViewRegisterSignIn);
  }
}
