// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/setting/change_password/change_password_screen.dart';
import 'package:furniture/screen/setting/report_bug_model.dart';
import 'package:furniture/screen/setting/translation/translate.dart';
import 'package:furniture/screen/setting/userProfile/edit_profile.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/static/settingtile.dart';
import 'package:furniture/static/topbar.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    TopBar(
                      ontap: () {},
                      text: 'Settings',
                      hide: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: SettingTile(
                        image: 'assets/images/editProfile.svg',
                        text: 'Edit Profile',
                        ontap: () {
                          Get.to(() => EditProfile());
                        },
                      ),
                    ),
                    authService.providerNames!.contains('google.com') == false
                        ? authService.providerNames!.contains('phone') == false
                            ? SettingTile(
                                image: 'assets/images/password.svg',
                                text: 'Change password',
                                ontap: () {
                                  settingController.clearPasswordVariable();
                                  Get.to(() => ChangePasswordscreen());
                                },
                              )
                            : Container()
                        : Container(),
                    SettingTile(
                      image: 'assets/images/language.svg',
                      text: 'Language',
                      ontap: () {
                        Get.to(() => TranslateScreen());
                      },
                    ),
                    SettingTile(
                      image: 'assets/images/report.svg',
                      text: 'Report Issue',
                      ontap: () {
                        settingController.clearbugVariables();
                        onBugTAp(context);
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  child: LargeButton(
                    title: "Log Out",
                    onPressed: () {
                      logout(context);
                      // settingController.signOut();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  onBugTAp(context) {
    Alert(context: context, content: BugReportModal(), buttons: [
      DialogButton(
          height: 0, color: white, onPressed: () async {}, child: Text(''))
    ]).show();
  }

  logout(context) {
    Alert(
      style: const AlertStyle(
        titleStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
      ),
      context: context,
      image: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SvgPicture.asset('assets/images/logout.svg'),
      ),
      title: "Are you sure that you want to logout?",
      buttons: [
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          child: Text(
            "Yes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            settingController.signOut();
          },
          color: mainColor,
        ),
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.black54,
          ),
          child: Text(
            "No",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
        ),
      ],
    ).show();
  }
}
