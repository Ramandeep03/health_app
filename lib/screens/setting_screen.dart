import 'package:flutter/material.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/providers/theme_provider.dart';
import 'package:health_app/services/overlay_services.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Consumer<ThemeProvider>(builder: (context, theme, child) {
              return ListTile(
                leading: const Icon(
                  Icons.dark_mode,
                  color: AppColors.green,
                ),
                title: Text(
                  Constants.darkMode,
                  style: TextStyles.headingMediumGreen,
                ),
                trailing: Switch(
                  value: theme.isDark ? true : false,
                  onChanged: (value) {
                    theme.toggleTheme();
                  },
                ),
              );
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () {
                OverlayServices.showLogoutDialog(context);
              },
              leading: const Icon(
                Icons.logout,
                color: AppColors.green,
              ),
              title: Text(
                Constants.logOut,
                style: TextStyles.headingMediumGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
