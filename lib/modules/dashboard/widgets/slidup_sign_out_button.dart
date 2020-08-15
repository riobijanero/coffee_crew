import 'package:coffee_crew/common/widgets/animated_loading_button.dart';
import 'package:flutter/material.dart';

class SlideUpSignOutButton extends StatelessWidget {
  const SlideUpSignOutButton({
    Key key,
    @required AnimationController screenController,
    @required this.slideUpAnimation,
    @required AnimationController buttonController,
    @required this.buttonSqueezeAnimation,
    @required this.buttonZoomoutAnimation,
    this.onTap,
  })  : _screenController = screenController,
        _buttonController = buttonController,
        super(key: key);

  final AnimationController _screenController;
  final Animation<double> slideUpAnimation;
  final AnimationController _buttonController;
  final Animation<double> buttonSqueezeAnimation;
  final Animation<double> buttonZoomoutAnimation;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _screenController,
      builder: (BuildContext context, Widget child) {
        return Align(
          alignment:
              Alignment(0, slideUpAnimation.value), //Alignment.bottomCenter,
          child: AnimatedLoadingButton(
            buttonController: _buttonController,
            buttonSqueezeAnimation: buttonSqueezeAnimation,
            buttonZoomoutAnimation: buttonZoomoutAnimation,
            onTab: onTap,
            buttontext: 'Sign out',
            buttonHeight: 60.0,
          ),
        );
      },
    );
  }
}
