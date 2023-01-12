import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/providers/auth_provider.dart';
import 'package:health_app/services/diemensions.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../styles/colors.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = Dimensions.getWidth(context);
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(Constants.verifyOTP),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              width: width,
              child: Column(
                children: [
                  Text(
                    Constants.otpSentTo+auth.phone,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    onChanged: ((value) {
                      auth.setOTP(value);
                    }),
                    controller: controller,
                    length: 6,
                    closeKeyboardWhenCompleted: true,
                    defaultPinTheme: PinTheme(
                        textStyle: TextStyles.headingLargeMediumGreen,
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black26,
                              blurRadius: 2,
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          color: AppColors.blue,
          padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          height: 80,
          width: width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: AppColors.textGreen),
            onPressed: () async {
              await auth.login(context);
            },
            child: auth.isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    Constants.submit,
                    style: TextStyles.headingThinWhite,
                  ),
          ),
        ),
      );
    });
  }
}
