
import 'package:flutter/material.dart';
import 'package:health_app/models/user_model.dart';

import 'package:health_app/providers/manage_profile_provider.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';
import '../styles/text_styles.dart';

class ManageProfileTile extends StatelessWidget {
  const ManageProfileTile({Key? key, required this.index, required this.user})
      : super(key: key);
  final int index;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Consumer<ManageProfileProvider>(builder: (context, profile, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: () {
            profile.changeProfile(index, context);
          },
          leading: const CircleAvatar(
            backgroundColor: AppColors.iconGrey,
            child: Icon(
              Icons.person_outline_outlined,
              color: AppColors.textBlue,
            ),
          ),
          title: Text(
            "${user.firstName} ${user.lastName}",
            style: TextStyles.headingMediumGreen,
          ),
          subtitle: Text(
            user.gender,
            style: TextStyles.headingMediumGreenSmall,
          ),
          trailing: Radio<int>(
            value: index,
            groupValue: profile.selectedProfileIndex,
            onChanged: (value) {
              profile.changeProfile(value!,context);
            },
          ),
        ),
      );
    });
  }
}
