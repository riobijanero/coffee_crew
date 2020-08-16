import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_controller.dart';
import '../../../common/widgets/animated_loading_button.dart';
import '../../../common/widgets/labeled_textfield.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool _passwordVisible;
  AnimationController _loginButtonController;

  Animation<double> buttonSqueezeAnimation;

  Animation<double> buttonZoomoutAnimation;

  void initState() {
    super.initState();
    _passwordVisible = false;
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 60.0,
    ).animate(CurvedAnimation(
        parent: _loginButtonController,
        curve: Interval(0.0, 0.250, curve: Curves.linearToEaseOut)));

    buttonZoomoutAnimation = Tween(
      begin: 70.0,
      end: 1000.0,
    ).animate(CurvedAnimation(
      parent: _loginButtonController,
      curve: Interval(0.550, 0.900, curve: Curves.bounceOut),
    ));
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  onPress(AuthenticationController _authenticationController) async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      _playAnimation();

      _authenticationController.onSignInButtonPressed(email, password);
    }
  }

  onRegisterButtonPressed(AuthenticationController authenticationController) {
    authenticationController.toggleViewRegisterSignIn();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationController>(
        builder: (context, _authenticationController, child) {
      return Scaffold(
        backgroundColor: Color(0xFF73AEF5),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 120.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign In to Coffee Crew',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40.0),
                LabeledTextfield(
                  labeltext: 'Email',
                  hintText: 'Enter your Email',
                  icon: Icon(Icons.email, color: Colors.white),
                  fillColor: Color(0xFF6CA8F1),
                  validator: (value) =>
                      _authenticationController.validateEmailField(value),
                  onChanged: (value) => setState(() => email = value),
                ),
                SizedBox(height: 20.0),
                LabeledTextfield(
                  labeltext: 'Password',
                  hintText: 'Enter a Password',
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  trailingIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      }),
                  obscureText: !_passwordVisible,
                  validator: (value) =>
                      _authenticationController.validatePasswordField(value),
                  onChanged: (value) => setState(() => password = value),
                ),
                SizedBox(height: 40.0),
                AnimatedLoadingButton(
                  buttonController: _loginButtonController,
                  buttonSqueezeAnimation: buttonSqueezeAnimation,
                  buttonZoomoutAnimation: buttonZoomoutAnimation,
                  onTab: () => onPress(_authenticationController),
                  buttontext: 'Sign in',
                ),
                SizedBox(height: 25.0),
                Text(
                  _authenticationController.signInErrorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ),
                SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () =>
                      onRegisterButtonPressed(_authenticationController),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an Account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
