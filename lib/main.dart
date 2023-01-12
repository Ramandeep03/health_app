import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_app/firebase_options.dart';
import 'package:health_app/providers/add_appointment_provider.dart';
import 'package:health_app/providers/appointment_provider.dart';
import 'package:health_app/providers/auth_provider.dart';
import 'package:health_app/providers/bottom_navigation_provider.dart';
import 'package:health_app/providers/manage_profile_provider.dart';
import 'package:health_app/providers/register_provider.dart';
import 'package:health_app/providers/theme_provider.dart';
import 'package:health_app/providers/user_provider.dart';
import 'package:health_app/routes/routes.dart';
import 'package:health_app/styles/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: ((context) => ThemeProvider()),
    ),
    ChangeNotifierProvider(
      create: ((context) => AuthProvider()),
    ),
    ChangeNotifierProvider(
      create: ((context) => RegisterProvider()),
    ),
    ChangeNotifierProvider(
      create: ((context) => BottomNavigationProvider()),
    ),
    ChangeNotifierProvider(
      create: ((context) => ManageProfileProvider()),
    ),
    ChangeNotifierProvider(
      create: ((context) => UserProvider()),
    ),
    ChangeNotifierProvider(
      create: ((context) =>AddAppointmentProvider()),
    ),
    ChangeNotifierProvider(
      create: ((context) =>AppointmentProvider()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, theme, child) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Health App',
        theme: theme.isDark ? Themes.darkTheme : Themes.lightTheme,
        routerDelegate: AppRoutes.routes.routerDelegate,
        routeInformationParser: AppRoutes.routes.routeInformationParser,
        routeInformationProvider: AppRoutes.routes.routeInformationProvider,
      );
    });
  }
}
