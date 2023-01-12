import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bottom_navigation_provider.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, controller, child) {
      return BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: (value) {
          controller.changeIndex(context, value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.lightbulb_sharp,
                  color: Colors.white,
                )),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Profiles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      );
    });
  }
}
