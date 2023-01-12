import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_app/models/user_model.dart';
import 'package:health_app/providers/manage_profile_provider.dart';
import 'package:health_app/providers/theme_provider.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:health_app/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../constants/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  changeScreen(BuildContext context) async {
    Provider.of<ThemeProvider>(context, listen: false).checkTheme();
    bool isLoggedIn = AuthServices.isLoggedIn();
    timer = Timer.periodic(const Duration(seconds: 2), (time) async {
      if (isLoggedIn) {
        DocumentSnapshot<Map<String, dynamic>> userData =
            await AuthServices.userDataAvailable();
        if (!mounted) return;
        if (userData.exists) {
          UserModel currentUser = UserModel.fromJSON(userData.data()!);
          await Provider.of<ManageProfileProvider>(context, listen: false)
              .fetchData(context);
          if (!mounted) return;
          await Provider.of<ManageProfileProvider>(context, listen: false)
              .changeProfile(currentUser.currentProfle, context);
          if (!mounted) return;
          context.replaceNamed(RoutesConstants.homeScreen);
        } else {
          context.replaceNamed(RoutesConstants.registerScreen);
        }
      } else {
        context.replaceNamed(RoutesConstants.loginScreen);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    changeScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(AssetPaths.logo),
      ),
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
