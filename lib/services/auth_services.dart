// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/keys.dart';
import 'package:go_router/go_router.dart';
import 'package:health_app/models/user_model.dart';
import 'package:health_app/providers/manage_profile_provider.dart';
import 'package:health_app/providers/theme_provider.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:health_app/services/message_service.dart';
import 'package:provider/provider.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String verificationId = '';

  static User? getUser() {
    return auth.currentUser;
  }

  static String? getPhone() {
    return auth.currentUser!.phoneNumber;
  }

  static bool isLoggedIn() {
    User? user = getUser();
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>>
      userDataAvailable() async {
    User user = getUser()!;
    String userId = user.uid;
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection(Keys.users).doc(userId).get();
    return doc;
  }

  static sendOtp(BuildContext context, String phone) async {
    verificationId = '';
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential cred) async {},
          verificationFailed: (FirebaseAuthException e) {
            MessageService.showMessage(context, e.message ?? '', true);
          },
          codeSent: (String id, int? resendToken) {
            verificationId = id;
            MessageService.showMessage(context, 'OTP SENT', false);
            context.replaceNamed(RoutesConstants.otpScreen);
          },
          codeAutoRetrievalTimeout: (String id) {});
    } catch (error) {
      print(error);
    }
  }

  static login(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await auth.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          DocumentSnapshot<Map<String, dynamic>> userData =
              await userDataAvailable();

          if (userData.exists) {
            UserModel currentUser = UserModel.fromJSON(userData.data()!);
            await Provider.of<ManageProfileProvider>(context, listen: false)
                .fetchData(context);
            await Provider.of<ManageProfileProvider>(context, listen: false)
                .changeProfile(currentUser.currentProfle, context);
            context.replaceNamed(RoutesConstants.homeScreen);
          } else {
            // ignore: use_build_context_synchronously
            context.replaceNamed(RoutesConstants.registerScreen);
          }
        }
      }).onError((error, stackTrace) {
        MessageService.showMessage(context, error.toString(), true);
      });
    } catch (e) {
      MessageService.showMessage(context, e.toString(), true);
    }
  }

  static logout(BuildContext context) async {
    await auth.signOut().then((value) {
      bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
      if (isDark) {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      }
      context.replaceNamed(RoutesConstants.loginScreen);
    });
  }
}
