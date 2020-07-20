import 'package:coffee_crew/common/widgets/bottom_sheet_container.dart';
import 'package:coffee_crew/models/coffee.dart';
import 'package:coffee_crew/common/widgets/settings_form/settings_form.dart';
import 'package:coffee_crew/services/database_service.dart';
import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';

class DashBoardController {
  final AuthService _authService = AuthService();
  final String appBarTitle = 'Coffe Crew';
  final String logOutButtonLabel = 'Log out';
  final String settingsButtonLabel = 'Settings';

  Future<void> onSignOutButtonPressed() async {
    await _authService.signOut();
  }

  Stream<List<Coffee>> get coffees => DatabaseService().coffees;

  void onSettingsButtonPressed(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BottomSheetContainer(child: SettingsForm());
        });
  }
}
