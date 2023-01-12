import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';

class HealthTextField extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final bool isEnabled;
  final TextEditingController controller;
  final bool isReadOnly;
  final TextInputType keyboard;
  final List<TextInputFormatter>? formatters;
  final Icon? trailing;
  final Color borderColor;
  final bool isFilled;
  final Color? fillColor;
  final Function(String?) onChange;
  const HealthTextField({
    Key? key,
    this.hintText = '',
    this.onTap,
    this.isEnabled = true,
    required this.controller,
    this.isReadOnly = false,
    this.keyboard = TextInputType.text,
    this.formatters,
    this.trailing,
    this.borderColor = AppColors.iconGrey,
    this.isFilled = false,
    this.fillColor,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        onChanged: ((value) {
          onChange(value);
        }),
        controller: controller,
        onTap: onTap,
        enabled: isEnabled,
        readOnly: isReadOnly,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.name,
        style: TextStyles.headingRegularBlue,
        decoration: InputDecoration(
          filled: isFilled,
          fillColor: fillColor,
          suffixIcon: trailing,
          suffixIconColor: AppColors.green,
          hintText: hintText,
          isDense: true,
          hintStyle: TextStyles.headingMediumGrey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: borderColor,
              width: 0.7,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: borderColor,
              width: 0.7,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: borderColor,
              width: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
