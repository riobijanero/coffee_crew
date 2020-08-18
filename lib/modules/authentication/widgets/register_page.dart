import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './authentication_controller.dart';
import '../../../common/widgets/animated_loading_button.dart';
import 'package:coffee_crew/common/widgets/labeled_textfield.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _repeatPasswordController =
      TextEditingController();

  String email = '';
  String password = '';
  String repeatPassword = '';
  AnimationController _loginButtonController;
  bool _passwordVisible;

  Animation<double> buttonSqueezeAnimation;

  Animation<double> buttonZoomoutAnimation;

  void initState() {
    super.initState();
    _passwordVisible = false;
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    buttonSqueezeAnimation = Tween(
      begin: 320.0,
      end: 70.0,
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

      _authenticationController.onRegisterButtonPressed(email, password);
    }
  }

  onSignInButtonPressed(AuthenticationController authenticationController) {
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
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 120.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Register For Coffee Crew',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 60.0),
                LabeledTextfield(
                  labeltext: 'Email',
                  hintText: 'Enter your Email',
                  icon: const Icon(Icons.email, color: Colors.white),
                  obscureText: false,
                  validator: (value) =>
                      _authenticationController.validateEmailField(value),
                  onChanged: (value) => setState(() => email = value),
                ),
                const SizedBox(height: 20.0),
                LabeledTextfield(
                  texteditController: _passwordController,
                  labeltext: 'Password',
                  hintText: 'Enter a Password',
                  icon: const Icon(
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
                const SizedBox(height: 20.0),
                LabeledTextfield(
                  texteditController: _repeatPasswordController,
                  labeltext: 'Repeat Password',
                  hintText: 'Repeat Password',
                  icon: const Icon(
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
                  validator: (value) {
                    return value != _passwordController.text
                        ? 'Passwords don\'t match'
                        : null;
                  },
                  onChanged: (value) => setState(() => repeatPassword = value),
                ),
                const SizedBox(height: 40.0),
                AnimatedLoadingButton(
                  buttonController: _loginButtonController,
                  buttonSqueezeAnimation: buttonSqueezeAnimation,
                  buttonZoomoutAnimation: buttonZoomoutAnimation,
                  onTab: () => onPress(_authenticationController),
                  buttontext: 'Register',
                ),
                const SizedBox(height: 25.0),
                Text(
                  _authenticationController.signInErrorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16.0),
                ),
                const SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () => onSignInButtonPressed(_authenticationController),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an Account? ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(
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
