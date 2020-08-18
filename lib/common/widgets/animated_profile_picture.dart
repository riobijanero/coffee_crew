import 'package:flutter/material.dart';

class AnimatedProfilePicture extends StatelessWidget {
  const AnimatedProfilePicture({
    Key key,
    @required AnimationController screenController,
    @required this.containerGrowAnimation,
    @required this.profileImage,
    @required this.numberOfNotifications,
  })  : _screenController = screenController,
        super(key: key);

  final AnimationController _screenController;
  final Animation<double> containerGrowAnimation;
  final ExactAssetImage profileImage;
  final int numberOfNotifications;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _screenController,
      builder: (BuildContext context, Widget child) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              Text(
                "Good Morning!",
                style: TextStyle(
                    fontSize: 30.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: containerGrowAnimation.value * 35,
                      height: containerGrowAnimation.value * 35,
                      margin: EdgeInsets.only(left: 80.0),
                      child: Center(
                        child: Text(numberOfNotifications.toString(),
                            style: TextStyle(
                                fontSize: containerGrowAnimation.value * 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromRGBO(80, 210, 194, 1.0),
                      ),
                    ),
                  ],
                ),
                width: containerGrowAnimation.value * 120,
                height: containerGrowAnimation.value * 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: profileImage),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
