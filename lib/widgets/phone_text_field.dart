import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';
import '../constants/regex.dart';
import '../styles/text_styles.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField(
      {Key? key, required this.controller, required this.onChange})
      : super(key: key);
  final TextEditingController controller;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  Constants.countryPrefix,
                  style: TextStyles.headingMediumGreen,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: VerticalDivider(
              thickness: 1,
            ),
          ),
          Expanded(
            flex: 13,
            child: TextField(
              onChanged: ((value) {
                onChange(value);
              }),
              controller: controller,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(
                  Regex.phoneNumber,
                )
              ],
              keyboardType: TextInputType.phone,
              maxLength: 10,
              style: TextStyles.headingRegularBlue,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: Constants.enterYourPhoneNumber,
                hintStyle: TextStyles.headingMediumGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
