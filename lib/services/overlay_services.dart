import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/providers/register_provider.dart';
import 'package:health_app/services/auth_services.dart';
import 'package:health_app/services/launcher_service.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:provider/provider.dart';

class OverlayServices {
  static datePicker(
    BuildContext context,
    TextEditingController controller,
  ) {
    showModalBottomSheet(
        isDismissible: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context, ) {
          DateTime selectedDate = DateTime.now();
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            height: 300,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      'Done',
                      style: TextStyles.headingRegularBlueSmall,
                    ),
                    onPressed: () {
                      print(selectedDate);
                      Provider.of<RegisterProvider>(context, listen: false)
                          .dateChange(selectedDate, controller);
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime date) {
                      selectedDate = date;
                    },
                    minimumDate: DateTime(
                      1900,
                    ),
                    maximumDate: DateTime.now(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static imagePicker(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Provider.of<RegisterProvider>(context, listen: false)
                            .pickImageFromGallery();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.image,
                        color: AppColors.green,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {
                        Provider.of<RegisterProvider>(context, listen: false)
                            .imageFromCamera();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: AppColors.green,
                        size: 40,
                      )),
                ],
              ),
            ),
          );
        });
  }

  static showEmergencyModal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 30,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Emergency Services',
                        style: TextStyles.headingThinWhite,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 0.5)),
                  child: ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.truckMedical,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Call Ambulance',
                      style: TextStyles.headingThinWhite,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await LauncherService.callService();
                      },
                      icon: const Icon(Icons.phone),
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 0.5)),
                  child: ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.hospital,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Call Hospital',
                      style: TextStyles.headingThinWhite,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await LauncherService.callService();
                      },
                      icon: const Icon(Icons.phone),
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  static showLoader(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (
          context,
        ) {
          return const Dialog(
            child: SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          );
        });
  }

  static showLogoutDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout?'),
            content: const Text('Do you really want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  AuthServices.logout(context);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }
}
