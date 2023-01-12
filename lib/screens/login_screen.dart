import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_app/constants/assets.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/providers/auth_provider.dart';
import 'package:health_app/services/diemensions.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:health_app/widgets/phone_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = Dimensions.getHeight(context);
    double width = Dimensions.getWidth(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              width: width,
              child: Consumer<AuthProvider>(builder: (context, auth, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AssetPaths.logo,
                      height: height * 0.05,
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AssetPaths.doctors,
                        width: width * 0.9,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      Constants.loginWithPhoneNumber,
                      style: TextStyles.headingMediumBlue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PhoneTextField(
                        controller: phoneController,
                        onChange: (value) {
                          auth.onChange(value!);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              auth.isValid ? AppColors.textGreen : Colors.grey,
                        ),
                        onPressed: auth.isValid
                            ? () {
                                auth.sendOtp(context).then((value) {});
                              }
                            : () {},
                        child: auth.isLoading
                            ? const Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                Constants.sentOTP,
                                style: TextStyles.headingThinWhite,
                              ),
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
