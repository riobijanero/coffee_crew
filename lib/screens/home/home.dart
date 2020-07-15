import 'package:coffee_crew/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffee_crew/models/coffee.dart';
import 'package:coffee_crew/services/auth_service.dart';
import 'package:coffee_crew/services/database_service.dart';

import 'coffee_list.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(25),
                    topRight: const Radius.circular(25)),
                // boxShadow: [
                //   BoxShadow(
                //       blurRadius: 1, color: Colors.blue[300], spreadRadius: 1)
                // ],
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService()
          .coffees, // <- this streams wraps the rest of thwdiget tree
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('coffee Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('log out'),
              onPressed: () async {
                await _authService.signOut();
              },
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('settings'),
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
