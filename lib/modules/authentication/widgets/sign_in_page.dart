import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_controller.dart';
import '../../../common/constants/constants.dart';
import '../../../common/widgets/loading_screen.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationController>(
        builder: (context, _authenticationController, child) {
      return _authenticationController.isSignInLoading
          ? LoadingScreen()
          : Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('sign in to Coffee Crew'),
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed:
                        _authenticationController.toggleViewRegisterSignIn,
                    icon: Icon(Icons.person),
                    label: Text('Register'),
                  )
                ],
              ),
              body: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (value) => _authenticationController
                              .validateEmailField(value),
                          onChanged: (value) => setState(() => email = value),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (value) => _authenticationController
                              .validatePasswordField(value),
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Colors.pink[400],
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _authenticationController.onSignInButtonPressed(
                                  email, password);
                            }
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          _authenticationController.signInErrorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  )),
            );
    });
  }
}
