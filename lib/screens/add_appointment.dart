import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/providers/add_appointment_provider.dart';
import 'package:health_app/routes/routes_constants.dart';
import 'package:health_app/services/diemensions.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import '../styles/colors.dart';

class AddAppointment extends StatelessWidget {
  const AddAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Dimensions.getWidth(context);
    Provider.of<AddAppointmentProvider>(context, listen: false).fetchDoctors();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.replaceNamed(RoutesConstants.homeScreen);
          },
          icon:const Icon(Icons.chevron_left),
        ),
        title: const Text(Constants.bookAppointment),
      ),
      body: Consumer<AddAppointmentProvider>(
          builder: (context, appointment, child) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shrinkWrap: true,
          children: [
            Text(
              appointment.search,
              style: TextStyles.headingLargeMediumGreen,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black26,
                    blurRadius: 1,
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColors.mediumBlue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    width: width,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Text(
                        Constants.selectDoctors,
                        style: TextStyles.headingMediumBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  appointment.doctorLoading
                      ? const SizedBox(
                          height: 100,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: appointment.selectedDoctor == index
                                      ? AppColors.textBlue
                                      : Colors.transparent,
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  appointment.setDoctor(index);
                                },
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      appointment.doctors[index].picURL),
                                ),
                                title: Text(appointment.doctors[index].name),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: appointment.doctors.length,
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black26,
                    blurRadius: 1,
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColors.mediumBlue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    width: width,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Text(
                        Constants.selectDateAndTime,
                        style: TextStyles.headingMediumBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TableCalendar(
                    selectedDayPredicate: (day) {
                      return isSameDay(appointment.selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      appointment.setDate(selectedDay);
                    },
                    calendarFormat: CalendarFormat.week,
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: AppColors.iconGreen,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: AppColors.iconGreen,
                      ),
                    ),
                    eventLoader: (day) {
                      List<DateTime> days = [];
                      if (day == DateTime.now().add(const Duration(days: 2))) {
                        days.add(day);
                      }
                      return days;
                    },
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.textBlue,
                      ),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green,
                      ),
                    ),
                    availableCalendarFormats: const {
                      CalendarFormat.week: 'Week'
                    },
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(
                      const Duration(days: 60),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 1,
                    children: appointment.times.map((e) {
                      return ChoiceChip(
                        label: Text(
                          e,
                        ),
                        selected: appointment.times.indexOf(e) ==
                                appointment.selectedTime
                            ? true
                            : false,
                        onSelected: (value) {
                          if (value) {
                            appointment.setTime(appointment.times.indexOf(e));
                          } else {
                            appointment.setTime(-1);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  appointment.bookAppointment(context);
                },
                child: appointment.booking
                    ? const Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        Constants.book,
                        style: TextStyles.headingThinWhite,
                      )),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      }),
    );
  }
}
