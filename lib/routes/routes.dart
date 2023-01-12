import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:health_app/screens/add_appointment.dart';
import 'package:health_app/screens/home_screen.dart';
import 'package:health_app/screens/login_screen.dart';
import 'package:health_app/screens/otp_screen.dart';
import 'package:health_app/screens/register_screen.dart';
import 'package:health_app/screens/splash_screen.dart';

class AppRoutes {
  static GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: RoutesConstants.spalshScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: [
          GoRoute(
            path: 'login',
            name: RoutesConstants.loginScreen,
            builder: (BuildContext context, GoRouterState state) {
              return  LoginScreen();
            },
          ),
          GoRoute(
            path: 'resgiter',
            name: RoutesConstants.registerScreen,
            builder: (BuildContext context, GoRouterState state) {
              return  RegisterScreen();
            },
          ),
          GoRoute(
            path: 'home',
            name: RoutesConstants.homeScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: 'otp',
            name: RoutesConstants.otpScreen,
            builder: (BuildContext context, GoRouterState state) {
              return  OtpScreen();
            },
          ),
          GoRoute(
            path: 'edit',
            name: RoutesConstants.addProfileScreen,
            builder: (BuildContext context, GoRouterState state) {
              return  RegisterScreen(
                isRegister: false,
              );
            },
          ),
          GoRoute(
            path: 'addAppointment',
            name: RoutesConstants.addAppointment,
            builder: (BuildContext context, GoRouterState state) {
              return const AddAppointment();
            },
          ),
        ],
      )
    ],
  );
}
