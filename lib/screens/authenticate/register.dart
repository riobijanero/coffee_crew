import 'package:coffee_crew/services/auth_service.dart';
import 'package:coffee_crew/shared/constants.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final void Function() toggleViewToSignIn;

  const Register({this.toggleViewToSignIn});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              title: Text('sign up to Coffee Crew'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: widget.toggleViewToSignIn,
                  icon: Icon(Icons.person),
                  label: Text('Sign in'),
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
                        obscureText: true,
                        validator: (String value) => value.length < 6
                            ? 'Enter a Password 6+ chars long'
                            : null, // if valid, it returns null
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            isLoading = true;
                            dynamic result = await _authService
                                .registerWithEmailAndPasswort(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'please supply a valid email';
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Register',
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
