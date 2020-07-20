import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './authentication_controller.dart';

import '../../../common/widgets/animation_effect.dart';
import '../../../common/constants/constants.dart';
import '../../../common/widgets/loading_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationController>(
        builder: (context, _authenticationController, child) {
      return _authenticationController.isRegistrationLoading
          ? LoadingScreen()
          : Scaffold(
              backgroundColor: Colors.brown[100],
              appBar: AppBar(
                backgroundColor: Colors.brown[400],
                elevation: 0.0,
                title: Text('sign up to Coffee Crew'),
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed:
                        _authenticationController.toggleViewRegisterSignIn,
                    icon: Icon(Icons.person),
                    label: Text('Sign in'),
                  )
                ],
              ),
              body: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: AnimationEffect(
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
                            obscureText: true,
                            validator: (value) => _authenticationController
                                .validatePasswordField(value),
                            onChanged: (value) =>
                                setState(() => password = value),
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: Colors.pink[400],
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _authenticationController
                                    .onRegisterButtonPressed(email, password);
                              }
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            _authenticationController.registrationErrorMessage,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ],
                      ),
                    ),
                  )),
            );
    });
  }
}
