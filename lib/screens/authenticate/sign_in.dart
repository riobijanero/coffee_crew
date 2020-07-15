import 'package:coffee_crew/services/auth_service.dart';
import 'package:coffee_crew/shared/constants.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final void Function() toggleViewToRegister;

  const SignIn({this.toggleViewToRegister});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('sign in to Coffee Crew'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: widget.toggleViewToRegister,
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (String value) =>
                            value.isEmpty ? 'Enter an eMail' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),

                        validator: (String value) => value.length < 6
                            ? 'Enter a Password 6+ chars long'
                            : null, // if valid, it returns null
                        obscureText: true,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => isLoading = true);
                            dynamic result = await _authService
                                .signInWithEmailAndPasswort(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those credentials';
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
