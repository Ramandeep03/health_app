import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/diemensions.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class HealthDropdown extends StatelessWidget {
  final value;
  final List<String> items;
  final String hintText;
  final Function(String) onChange;
  const HealthDropdown({
    Key? key,
    required this.value,
    required this.items,
    this.hintText = '',
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Dimensions.getWidth(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: AppColors.green)),
      width: width,
      child: DropdownButton<String>(
        iconEnabledColor: AppColors.green,
        isExpanded: true,
        underline: Container(),
        value: value,
        hint: Text(hintText, style: TextStyles.headingMediumGreen),
        items: items.map((e) {
          return DropdownMenuItem<String>(
            value: e,
            child: Text(e, style: TextStyles.headingMediumGreen),
          );
        }).toList(),
        onChanged: (changeValue) {
          onChange(changeValue!);
        },
      ),
    );
  }
}
