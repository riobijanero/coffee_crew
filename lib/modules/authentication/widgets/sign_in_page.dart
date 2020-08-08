import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_controller.dart';
import '../../../common/constants/constants.dart';
import '../../../common/widgets/loading_screen.dart';
import '../../../common/widgets/animation_effect.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  AnimationController _loginButtonController;

  Animation<double> buttonSqueezeAnimation;

  Animation<double> buttonZoomoutAnimation;

  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    buttonSqueezeAnimation = new Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(new CurvedAnimation(
        parent: _loginButtonController,
        curve: new Interval(0.0, 0.250, curve: Curves.linearToEaseOut)));

    buttonZoomoutAnimation = new Tween(
      begin: 70.0,
      end: 1000.0,
    ).animate(new CurvedAnimation(
      parent: _loginButtonController,
      curve: new Interval(0.550, 0.900, curve: Curves.bounceOut),
    ));
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  onPress(AuthenticationController _authenticationController) async {
    if (_formKey.currentState.validate()) {
      _playAnimation();

      _authenticationController.onSignInButtonPressed(email, password);
    }
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
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('sign in to Coffee Crew'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: _authenticationController.toggleViewRegisterSignIn,
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
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (value) =>
                        _authenticationController.validateEmailField(value),
                    onChanged: (value) => setState(() => email = value),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (value) =>
                        _authenticationController.validatePasswordField(value),
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                  ),
                  SizedBox(height: 40.0),
                  AnimatedLoadingButton(
                    buttonController: _loginButtonController,
                    buttonSqueezeAnimation: buttonSqueezeAnimation,
                    buttonZoomoutAnimation: buttonZoomoutAnimation,
                    onTab: () => onPress(_authenticationController),
                    buttontext: 'Sign in',
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

class AnimatedLoadingButton extends StatelessWidget {
  final Function onTab;
  final AnimationController buttonController;
  final Animation<double> buttonSqueezeAnimation;
  final Animation<double> buttonZoomoutAnimation;
  final String buttontext;

  const AnimatedLoadingButton(
      {Key key,
      this.buttontext,
      this.onTab,
      this.buttonController,
      this.buttonSqueezeAnimation,
      this.buttonZoomoutAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonController,
      builder: (BuildContext context, Widget child) {
        return new InkWell(
            onTap: onTab,
            child: new Hero(
              tag: "fade",
              child: new Container(
                  width: buttonSqueezeAnimation.value,
                  height: 60.0,
                  alignment: FractionalOffset.center,
                  decoration: new BoxDecoration(
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                      borderRadius:
                          BorderRadius.all(const Radius.circular(30.0))),
                  child: buttonSqueezeAnimation.value > 75.0
                      ? new Text(
                          buttontext,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.3,
                          ),
                        )
                      : new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 1.0,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        )),
            ));
      },
    );
  }
}

/**
 *  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonController,
      builder: (BuildContext context, Widget child) {
        return Padding(
          padding: buttonZoomoutAnimation.value == 70
              ? const EdgeInsets.only(
                  bottom: 50.0,
                )
              : const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: new InkWell(
              onTap: onTab,
              child: new Hero(
                tag: "fade",
                child: new Container(
                    width: buttonZoomoutAnimation.value == 70
                        ? buttonSqueezeAnimation.value
                        : buttonZoomoutAnimation.value,
                    height: buttonZoomoutAnimation.value == 70
                        ? 60.0
                        : buttonZoomoutAnimation.value,
                    alignment: FractionalOffset.center,
                    decoration: new BoxDecoration(
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                      borderRadius: buttonZoomoutAnimation.value < 400
                          ? new BorderRadius.all(const Radius.circular(30.0))
                          : new BorderRadius.all(const Radius.circular(0.0)),
                    ),
                    child: buttonSqueezeAnimation.value > 75.0
                        ? new Text(
                            buttontext,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3,
                            ),
                          )
                        : buttonZoomoutAnimation.value < 300.0
                            ? new CircularProgressIndicator(
                                value: null,
                                strokeWidth: 1.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )
                            : null),
              )),
        );
      },
    );
 */
