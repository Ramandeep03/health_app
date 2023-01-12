import 'package:flutter/material.dart';
import 'package:health_app/providers/bottom_navigation_provider.dart';
import 'package:health_app/screens/appointment_screen.dart';
import 'package:health_app/screens/home.dart';
import 'package:health_app/screens/manage_profile_screen.dart';
import 'package:health_app/screens/setting_screen.dart';
import 'package:health_app/widgets/app_bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, controller, child) {
      return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.controller,
          children: [
            Home(),
            const AppointmentScreen(),
            Container(),
            const ManageProfileScreen(),
            const SettingScreen(),
          ],
        ),
        bottomNavigationBar: const AppBottomNavigation(),
      );
    });
  }
}
