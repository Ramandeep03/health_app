import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/providers/add_appointment_provider.dart';
import 'package:health_app/providers/bottom_navigation_provider.dart';
import 'package:health_app/providers/user_provider.dart';
import 'package:health_app/services/diemensions.dart';
import 'package:health_app/services/overlay_services.dart';
import 'package:health_app/services/search_service.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:health_app/widgets/health_text_field.dart';
import 'package:provider/provider.dart';

import '../constants/assets.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = Dimensions.getWidth(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<UserProvider>(builder: (context, user, child) {
                  return Text(
                    '${Constants.welcome} ${user.user!.firstName}',
                    style: TextStyles.headingLargeMediumGreen,
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Constants.bookAnAppointment,
                        style: TextStyles.headingMediumBlue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          OverlayServices.showLoader(context);
                          await Provider.of<AddAppointmentProvider>(context,
                                  listen: false)
                              .fetchData();
                          Navigator.pop(context);
                          showSearch(
                              context: context, delegate: SearchService());
                        },
                        child: HealthTextField(
                          isEnabled: false,
                          onChange: (value) {},
                          fillColor: AppColors.blue,
                          isFilled: true,
                          controller: controller,
                          hintText: Constants.searchSpeacialty,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<BottomNavigationProvider>(context,
                            listen: false)
                        .changeIndex(context, 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                         Constants.seeUpcomingAppointments,
                          style: TextStyles.headingMediumGreen,
                        ),
                        const Icon(Icons.chevron_right)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AssetPaths.doctors,
                    width: width * 0.7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
