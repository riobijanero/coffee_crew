import 'package:flutter/material.dart';

class AnimatedLoadingButton extends StatelessWidget {
  final Function onTab;
  final AnimationController buttonController;
  final Animation<double> buttonSqueezeAnimation;
  final Animation<double> buttonZoomoutAnimation;
  final String buttontext;
  final double buttonHeight;

  const AnimatedLoadingButton({
    Key key,
    this.buttontext,
    this.onTab,
    this.buttonController,
    this.buttonSqueezeAnimation,
    this.buttonZoomoutAnimation,
    this.buttonHeight = 60.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonController,
      builder: (BuildContext context, Widget child) {
        return InkWell(
            onTap: onTab,
            child: Hero(
              tag: "fade",
              child: Container(
                  width: buttonSqueezeAnimation.value,
                  height: buttonHeight,
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 64, 106, 1.0),
                      borderRadius:
                          BorderRadius.all(const Radius.circular(30.0))),
                  child: buttonSqueezeAnimation.value > 75.0
                      ? Text(
                          buttontext,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.3,
                          ),
                        )
                      : CircularProgressIndicator(
                          strokeWidth: 1.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )),
            ));
      },
    );
  }
}
