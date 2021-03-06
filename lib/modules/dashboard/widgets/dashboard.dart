import 'package:coffee_crew/common/widgets/animated_profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_controller.dart';
import '../../../models/coffee.dart';
import './slidup_sign_out_button.dart';
import '../../../common/widgets/coffee_list/coffee_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  DashBoardController _dashBoardController;
  AnimationController _screenController;
  AnimationController _buttonController;
  Animation buttonZoomOutAnimation;

  Animation<double> containerGrowAnimation;
  Animation<double> buttonGrowAnimation;
  Animation<double> listTileWidth;
  Animation<Alignment> listSlideAnimation;
  Animation<EdgeInsets> listSlidePosition;

  Animation<double> slideUpAnimation;

  Animation<double> buttonSqueezeAnimation;

  Animation<double> buttonZoomoutAnimation;

  static const profileImage = const ExactAssetImage('assets/bijan.png');

  @override
  void initState() {
    super.initState();
    _screenController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    containerGrowAnimation = CurvedAnimation(
      parent: _screenController,
      curve: Interval(
        0.225,
        0.550,
        curve: Curves.linearToEaseOut,
      ),
    );

    buttonGrowAnimation = CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeOut,
    );

    listTileWidth = Tween<double>(
      begin: 1000.0,
      end: 600.0,
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Interval(
          0.225,
          0.600,
          curve: Curves.bounceIn,
        ),
      ),
    );
    listSlideAnimation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Interval(
          0.325,
          0.500,
          curve: Curves.ease,
        ),
      ),
    );
    listSlidePosition = EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 16.0),
      end: const EdgeInsets.only(bottom: 80.0),
    ).animate(
      CurvedAnimation(
        parent: _screenController,
        curve: Interval(
          0.325,
          0.800,
          curve: Curves.ease,
        ),
      ),
    );

    buttonSqueezeAnimation = Tween(
      begin: 160.0,
      end: 60.0,
    ).animate(CurvedAnimation(
        parent: _buttonController,
        curve: const Interval(0.0, 0.250, curve: Curves.linearToEaseOut)));

    buttonZoomoutAnimation = Tween(
      begin: 70.0,
      end: 1000.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: const Interval(0.550, 0.900, curve: Curves.bounceOut),
    ));

    slideUpAnimation = Tween<double>(
      begin: 1.4,
      end: 0.90,
    ).animate(CurvedAnimation(
      parent: _screenController,
      curve: const Interval(
        0.325,
        0.700,
        curve: Curves.linearToEaseOut,
      ),
    ));

    _screenController.forward();
  }

  void logOut() async {
    await _buttonController.forward();
    await _dashBoardController.onSignOutButtonPressed();
    // await _buttonController.reverse();
  }

  _onEditOrderButtonPressed(BuildContext context) {
    _dashBoardController.onSettingsButtonPressed(context);
  }

  @override
  Widget build(BuildContext context) {
    _dashBoardController = Provider.of<DashBoardController>(context);

    return StreamProvider<List<Coffee>>.value(
        value: _dashBoardController
            .coffees, // <- this streams wraps the rest of thwdiget tree
        child: Scaffold(
            backgroundColor: Color(0xFF6CA8F1),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () => _onEditOrderButtonPressed(context),
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    label: Text(
                      _dashBoardController.settingsButtonLabel,
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: LayoutBuilder(
              builder: (ctx, constrains) {
                return Stack(
                  children: <Widget>[
                    Container(
                      height: constrains.maxHeight,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              height: 220,
                              child: AnimatedProfilePicture(
                                screenController: _screenController,
                                containerGrowAnimation: containerGrowAnimation,
                                profileImage: profileImage,
                                numberOfNotifications: 3,
                              ),
                            ),
                            CoffeeList(
                              screenController: _screenController,
                              listSlidePosition: listSlidePosition,
                              listSlideAnimation: listSlideAnimation,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SlideUpSignOutButton(
                      screenController: _screenController,
                      slideUpAnimation: slideUpAnimation,
                      buttonController: _buttonController,
                      buttonSqueezeAnimation: buttonSqueezeAnimation,
                      buttonZoomoutAnimation: buttonZoomoutAnimation,
                      onTap: logOut,
                    ),
                  ],
                );
              },
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _screenController.dispose();
    _buttonController.dispose();
  }
}
