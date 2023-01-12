import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/assets.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/providers/appointment_provider.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<AppointmentProvider>(context, listen: false).fetchData(context);
    return Consumer<AppointmentProvider>(
        builder: (context, appointment, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            Constants.appointments,
          ),
        ),
        body: appointment.isLoading
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.green,
                ),
              )
            : appointment.appointments.isNotEmpty
                ? ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Constants.upcomingAppointments,
                        style: TextStyles.headingLargeMediumGreen,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: AppColors.iconGrey,
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: AppColors.iconGreen,
                                  ),
                                ),
                                title: Text(
                                  '${appointment.appointments[index].title} with ${appointment.appointments[index].doctor}',
                                  style: TextStyles.headingMediumGreen,
                                ),
                                subtitle: Text(
                                  '${appointment.appointments[index].day} between ${appointment.appointments[index].time}',
                                  style: TextStyles.headingMediumGreenSmall,
                                ),
                              ),
                            );
                          }),
                          separatorBuilder: ((context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          }),
                          itemCount: appointment.appointments.length)
                    ],
                  )
                : const Center(
                    child: Image(image: AssetImage(AssetPaths.noData))),
      );
    });
  }
}
