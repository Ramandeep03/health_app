import 'package:flutter/material.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';

class MessageService {
  static showMessage(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyles.headingThinWhite,
      ),
      backgroundColor: isError ? Colors.red : AppColors.textBlue,
    ));
  }
}
