import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/providers/manage_profile_provider.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/widgets/manage_profile_tile.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ManageProfileScreen extends StatelessWidget {
  const ManageProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ManageProfileProvider>(context, listen: false)
        .fetchData(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.patientProfile),
        actions: [
          IconButton(
            onPressed: () {
              context.replaceNamed(RoutesConstants.addProfileScreen);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Consumer<ManageProfileProvider>(builder: (context, profile, child) {
        return profile.isLoading
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.green,
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ManageProfileTile(
                    index: index,
                    user: profile.users[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: profile.users.length,
              );
      }),
    );
  }
}
