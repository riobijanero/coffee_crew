import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../services/database_service.dart';
import '../../constants/constants.dart';
import '../loading_screen.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName, _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream:
            DatabaseService(uid: user.uid).userData, //listening to that stream
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Your coffee settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    validator: (String value) =>
                        value.isEmpty ? 'Enter a Name' : null,
                    onChanged: (value) {
                      setState(() => _currentName = value);
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars
                        .map((sugar) => DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            ))
                        .toList(),
                    onChanged: (String value) =>
                        setState(() => _currentSugars = value),
                  ),
                  SizedBox(height: 20),
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown,
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (value) =>
                        setState(() => _currentStrength = value.round()),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.pink[400],
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context); // to shut the bottom sheet
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return LoadingScreen();
          }
        });
  }
}
