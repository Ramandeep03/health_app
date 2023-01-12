import 'package:flutter/material.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';

class Themes {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyles.headingLargeMediumGreen,
      iconTheme: const IconThemeData(
        color: AppColors.green,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.mediumBlue,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.green,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.textBlue,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: AppColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ))),
    iconTheme: const IconThemeData(
      color: AppColors.green,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.iconGreen,
      backgroundColor: Colors.grey,
      selectedIconTheme: const IconThemeData(
        color: AppColors.iconGreen,
        size: 28,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppColors.iconGreen,
        size: 26,
      ),
      unselectedLabelStyle: TextStyles.headingMediumGreenVerySmall,
      type: BottomNavigationBarType.fixed,
    ),
    chipTheme: ChipThemeData(
      labelStyle: TextStyles.headingThinWhiteSmall,
      selectedColor: AppColors.textBlue,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.green),
      trackColor: MaterialStateProperty.all(AppColors.textGreen),
    ),
  );
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blue,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyles.headingLargeMediumGreen,
      iconTheme: const IconThemeData(
        color: AppColors.green,
      ),
    ),
    scaffoldBackgroundColor: AppColors.blue,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.mediumBlue,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.green,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.textBlue,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: AppColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ))),
    iconTheme: const IconThemeData(
      color: AppColors.green,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.iconGreen,
      backgroundColor: Colors.white,
      selectedIconTheme: const IconThemeData(
        color: AppColors.iconGreen,
        size: 28,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppColors.iconGreen,
        size: 26,
      ),
      unselectedLabelStyle: TextStyles.headingMediumGreenVerySmall,
      type: BottomNavigationBarType.fixed,
    ),
    chipTheme: ChipThemeData(
      labelStyle: TextStyles.headingThinWhiteSmall,
      selectedColor: AppColors.textBlue,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.green),
      trackColor: MaterialStateProperty.all(AppColors.textGreen),
    ),
  );
}
