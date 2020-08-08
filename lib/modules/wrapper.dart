import 'package:coffee_crew/models/user.dart';
import './authentication/widgets/authentication_wrapper.dart';
import 'package:coffee_crew/modules/dashboard/widgets/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: (user == null) ? AuthenticationWrapper() : Dashboard(),
    );
  }
}
