import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './authentication_controller.dart';
import '../../../common/widgets/animated_loading_button.dart';
import '../../../common/constants/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  AnimationController _loginButtonController;

  Animation<double> buttonSqueezeAnimation;

  Animation<double> buttonZoomoutAnimation;

  void initState() {
    super.initState();
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
                  'Register For Coffee Crew',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email',
                      style: textFormFieldLabelStyle,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      cursorColor: textFormFieldFontStyle.color,
                      style: textFormFieldFontStyle,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Enter your Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) =>
                          _authenticationController.validateEmailField(value),
                      onChanged: (value) => setState(() => email = value),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Password',
                      style: textFormFieldLabelStyle,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      style: textFormFieldFontStyle,
                      cursorColor: textFormFieldFontStyle.color,
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Enter a Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) => _authenticationController
                          .validatePasswordField(value),
                      onChanged: (value) => setState(() => password = value),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                AnimatedLoadingButton(
                  buttonController: _loginButtonController,
                  buttonSqueezeAnimation: buttonSqueezeAnimation,
                  buttonZoomoutAnimation: buttonZoomoutAnimation,
                  onTab: () => onPress(_authenticationController),
                  buttontext: 'Register',
                ),
                SizedBox(height: 25.0),
                Text(
                  _authenticationController.signInErrorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ),
                SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () => onSignInButtonPressed(_authenticationController),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an Account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign in',
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

  // final _formKey = GlobalKey<FormState>();

  // String email = '';
  // String password = '';

  // @override
  // Widget build(BuildContext context) {
  //   return Consumer<AuthenticationController>(
  //       builder: (context, _authenticationController, child) {
  //     return _authenticationController.isRegistrationLoading
  //         ? LoadingScreen()
  //         : Scaffold(
  //             backgroundColor: Colors.brown[100],
  //             appBar: AppBar(
  //               backgroundColor: Colors.brown[400],
  //               elevation: 0.0,
  //               title: Text('sign up to Coffee Crew'),
  //               actions: <Widget>[
  //                 FlatButton.icon(
  //                   onPressed:
  //                       _authenticationController.toggleViewRegisterSignIn,
  //                   icon: Icon(Icons.person),
  //                   label: Text('Sign in'),
  //                 )
  //               ],
  //             ),
  //             body: Container(
  //                 padding:
  //                     EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
  //                 child: Form(
  //                   key: _formKey,
  //                   child: Column(
  //                     children: <Widget>[
  //                       SizedBox(height: 20.0),
  //                       TextFormField(
  //                         decoration:
  //                             textInputDecoration.copyWith(hintText: 'Email'),
  //                         validator: (value) => _authenticationController
  //                             .validateEmailField(value),
  //                         onChanged: (value) => setState(() => email = value),
  //                       ),
  //                       SizedBox(height: 20.0),
  //                       TextFormField(
  //                         decoration: textInputDecoration.copyWith(
  //                             hintText: 'Password'),
  //                         obscureText: true,
  //                         validator: (value) => _authenticationController
  //                             .validatePasswordField(value),
  //                         onChanged: (value) =>
  //                             setState(() => password = value),
  //                       ),
  //                       SizedBox(height: 20.0),
  //                       RaisedButton(
  //                         color: Colors.pink[400],
  //                         onPressed: () async {
  //                           if (_formKey.currentState.validate()) {
  //                             _authenticationController.onRegisterButtonPressed(
  //                                 email, password);
  //                           }
  //                         },
  //                         child: Text(
  //                           'Register',
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                       SizedBox(height: 12.0),
  //                       Text(
  //                         _authenticationController.registrationErrorMessage,
  //                         style: TextStyle(color: Colors.red, fontSize: 14.0),
  //                       )
  //                     ],
  //                   ),
  //                 )),
  //           );
  //   });
  // }
}
