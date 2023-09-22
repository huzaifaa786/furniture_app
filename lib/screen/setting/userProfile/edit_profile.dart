// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/setting/setting_controller.dart';
import 'package:furniture/screen/setting/success_model.dart';
import 'package:furniture/static/input_field1.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/static/topbar.dart';
import 'package:furniture/values/Validator.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    settingController.initializeUserModel(auth.currentUser!.uid);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<SettingController>(
            builder: (controller) => Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(
                    text: 'profile'.tr,
                    ontap: () {
                      Get.back();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'username'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.54,
                      ),
                    ),
                  ),
                  InputField1(
                    hint: 'username'.tr,
                    icon: 'assets/images/user.svg',
                    controller: controller.name,
                    validate: controller.validateEditProfileForm,
                    validator: (field) =>
                        Validators.emptyStringValidator(field, '*username '),
                  ),
                  authService.providerNames!.contains('phone') == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text(
                                'email_address'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  // fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.54,
                                ),
                              ),
                            ),
                            InputField1(
                              icon: 'assets/images/email.svg',
                              hint: 'email_address'.tr,
                              controller: controller.email,
                              readOnly: true,
                              type: TextInputType.emailAddress,
                              validate: controller.validateEditProfileForm,
                              validator: (field) =>
                                  Validators.emailValidator(field),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Text(
                                'Phone_Number'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  // fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.54,
                                ),
                              ),
                            ),
                            InputField1(
                              icon: 'assets/images/phone.svg',
                              hint: 'Phone_Number'.tr,
                              controller: controller.phone,
                              readOnly: true,
                              // type: TextInputType.emailAddress,
                              // validate: controller.validateEditProfileForm,
                              // validator: (field) => Validators.emailValidator(field),
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: LargeButton(
                      title: 'save'.tr,
                      sreenRatio: 0.9,
                      onPressed: () {
                        settingController.updateProfile((success) {
                          if (success) {
                            Get.back();
                            successModel(context);
                          }
                        });
                      },
                      textcolor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  successModel(context) {
    Alert(
        context: context,
        content: SucessModel(
          text: 'Updated\nSuccessfully',
        ),
        buttons: [
          DialogButton(
              height: 0, color: white, onPressed: () async {}, child: Text(''))
        ]).show();
  }
}
