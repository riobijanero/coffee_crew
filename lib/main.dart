import 'package:coffee_crew/models/user.dart';
import 'package:coffee_crew/modules/authentication/widgets/authentication_controller.dart';
import 'package:coffee_crew/modules/dashboard/widgets/dashboard_controller.dart';
import 'package:coffee_crew/modules/wrapper.dart';
import 'package:coffee_crew/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthenticationController(context)),
        StreamProvider<User>.value(value: AuthService().user),
        Provider<DashBoardController>(create: (_) => DashBoardController()),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
