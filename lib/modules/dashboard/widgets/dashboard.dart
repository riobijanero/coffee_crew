import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_controller.dart';
import '../../../models/coffee.dart';
import '../../../common/widgets/coffee_list/coffee_list.dart';

class Dashboard extends StatelessWidget {
  DashBoardController _dashBoardController;

  @override
  Widget build(BuildContext context) {
    _dashBoardController = Provider.of<DashBoardController>(context);

    return StreamProvider<List<Coffee>>.value(
      value: _dashBoardController
          .coffees, // <- this streams wraps the rest of thwdiget tree
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text(_dashBoardController.appBarTitle),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text(_dashBoardController.logOutButtonLabel),
              onPressed: () async {
                await _dashBoardController.onSignOutButtonPressed();
              },
            ),
            FlatButton.icon(
              onPressed: () =>
                  _dashBoardController.onSettingsButtonPressed(context),
              icon: Icon(Icons.settings),
              label: Text(_dashBoardController.settingsButtonLabel),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: CoffeeList(),
        ),
      ),
    );
  }
}
