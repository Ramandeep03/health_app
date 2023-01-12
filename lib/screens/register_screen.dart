import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/constants/constants.dart';
import 'package:health_app/constants/list_constant.dart';
import 'package:health_app/providers/register_provider.dart';
import 'package:health_app/services/diemensions.dart';
import 'package:health_app/styles/colors.dart';
import 'package:health_app/styles/text_styles.dart';
import 'package:health_app/widgets/health_dropdown.dart';
import 'package:health_app/widgets/health_text_field.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key, this.isRegister = true, this.edit = false})
      : super(key: key);
  final bool isRegister;
  final bool edit;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyNumberController =
      TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = Dimensions.getWidth(context);
    if (Provider.of<RegisterProvider>(context, listen: false).states.isEmpty) {
      Provider.of<RegisterProvider>(context, listen: false)
          .fetchStateAndCity(phoneController);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.patientProfile),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child:
              Consumer<RegisterProvider>(builder: (context, register, child) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    register.imageOverlay(context);
                  },
                  child: Container(
                    height: 100,
                    width: 100,
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
                    child: Stack(
                      children: [
                        register.image.path.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  File(register.image.path),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.all(5),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppColors.iconGrey,
                                  child: Icon(
                                    Icons.person_rounded,
                                    size: 90,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        const Positioned(
                          right: 2,
                          bottom: 5,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.green,
                            child: Icon(
                              Icons.edit,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            Constants.personalDetails,
                            style: TextStyles.headingMediumBlue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.name,
                              onChange: ((text) {
                                register.firstNameChange(text!);
                              }),
                              controller: firstNameController,
                              hintText: 'Enter First Name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Last Name *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.name,
                              onChange: ((text) {
                                register.lastNameChange(text!);
                              }),
                              controller: lastNameController,
                              hintText: 'Enter Last Name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Phone Number *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              onChange: ((text) {
                                register.phoneChange(text!);
                              }),
                              isEnabled: false,
                              isFilled: true,
                              keyboard: TextInputType.number,
                              fillColor: AppColors.iconGrey,
                              controller: phoneController,
                              hintText: 'Enter Phone Number',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Email *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.emailAddress,
                              onChange: ((text) {
                                register.emailChange(text!);
                              }),
                              controller: emailController,
                              hintText: 'Enter Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Gender *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthDropdown(
                                hintText: 'Select Gender',
                                value: register.gender.isEmpty
                                    ? null
                                    : register.gender,
                                items: ListConstants.gender,
                                onChange: (value) {
                                  register.genderTap(value);
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Nationality *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthDropdown(
                                value: register.nationality.isEmpty
                                    ? null
                                    : register.nationality,
                                items: const ['Indian'],
                                onChange: (value) {
                                  register.nationalityTap(value);
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Marital Status',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthDropdown(
                              value: register.maritalStatus.isEmpty
                                  ? null
                                  : register.maritalStatus,
                              items: ListConstants.martialStatus,
                              onChange: (value) {
                                register.maritalStatusTap(value);
                              },
                              hintText: 'Select Marital Status',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Blood Group',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthDropdown(
                              value: register.bloodGroup.isEmpty
                                  ? null
                                  : register.bloodGroup,
                              items: ListConstants.bloodGroup,
                              onChange: (value) {
                                register.bloodGroupTap(value);
                              },
                              hintText: 'Select Blood Group',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Date of Birth *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              onChange: ((text) {}),
                              onTap: () {
                                register.pickChange(context, dobController);
                              },
                              borderColor: AppColors.green,
                              controller: dobController,
                              isReadOnly: true,
                            
                              trailing: const Icon(
                                Icons.calendar_month_outlined,
                                color: AppColors.green,
                              ),
                              hintText: 'Choose Date',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Emergency Contact Name',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.name,
                              onChange: ((text) {
                                register.emergencyNameChange(text!);
                              }),
                              controller: emergencyNameController,
                              hintText: 'Enter Emergency Contact Name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Emergency Contact Number',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.phone,
                              onChange: ((text) {
                                register.emergencyNumberChange(text!);
                              }),
                              controller: emergencyNumberController,
                              hintText: 'Enter Emergency Contact Number',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Address Line 1 *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.streetAddress,
                              onChange: ((text) {
                                register.address1Change(text!);
                              }),
                              controller: address1Controller,
                              hintText: 'Enter Address Line 1 *',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Address Line 2',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.streetAddress,
                              onChange: ((text) {
                                register.address2Change(text!);
                              }),
                              controller: address2Controller,
                              hintText: 'Enter Address Line 2',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Country *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthDropdown(
                              value: register.country.isEmpty
                                  ? null
                                  : register.country,
                              items: const ['India'],
                              onChange: (value) {
                                register.countryTap(value);
                              },
                              hintText: 'Select Country',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'State *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthDropdown(
                              hintText: 'Select State',
                              value: register.selectedState.isEmpty
                                  ? null
                                  : register.selectedState,
                              items: register.states,
                              onChange: (value) {
                                register.stateChange(value);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'City *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthDropdown(
                              hintText: 'Select City',
                              value: register.selectedCity.isEmpty
                                  ? null
                                  : register.selectedCity,
                              items: register.city,
                              onChange: (value) {
                                register.cityChange(value);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Pincode *',
                              style: TextStyles.headingRegularBlueSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            HealthTextField(
                              keyboard: TextInputType.number,
                              onChange: ((text) {
                                register.pinCodeChange(text!);
                              }),
                              controller: pincodeController,
                              hintText: 'Enter Pincode',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            );
          }),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.blue,
        padding:
            const EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 20),
        height: 100,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: AppColors.textGreen),
          onPressed: () {
            Provider.of<RegisterProvider>(context, listen: false)
                .uploadData(context, isRegister);
          },
          child: Provider.of<RegisterProvider>(context).uploading
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Create Profile',
                  style: TextStyles.headingThinWhite,
                ),
        ),
      ),
    );
  }
}
