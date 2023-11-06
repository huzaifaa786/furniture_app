// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/bottomNavBar/bottomNaviBar.dart';
import 'package:furniture/screen/login/login_screen.dart';
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
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      // orderController.getItemsStream(query: '');
    } else {
      Future.delayed(Duration.zero, () {
        setState(() {
          // Your state changes here
          Get.to(() => LoginScreen())!.then((value) {
            Get.offAll(() => BottomNavScreen());
          });
        });
      });
    }
  }

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
                    text: 'settings'.tr,
                    hide: true,
                  ),
                  auth.currentUser != null
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SettingTile(
                                image: 'assets/images/editProfile.svg',
                                text: 'Edit_profile'.tr,
                                ontap: () {
                                  Get.to(() => EditProfile());
                                },
                              ),
                            ),
                            SettingTile(
                              image: 'assets/images/delAcc.svg',
                              text: 'Delete Account'.tr,
                              ontap: () {
                                deleteProfile(context);
                              },
                            ),
                            authService.providerNames!.contains('apple.com') ==
                                    false
                                ? authService.providerNames!
                                            .contains('google.com') ==
                                        false
                                    ? authService.providerNames!
                                                .contains('phone') ==
                                            false
                                        ? SettingTile(
                                            image: 'assets/images/password.svg',
                                            text: 'change_password'.tr,
                                            ontap: () {
                                              settingController
                                                  .clearPasswordVariable();
                                              Get.to(
                                                  () => ChangePasswordscreen());
                                            },
                                          )
                                        : Container()
                                    : Container()
                                : Container(),
                            SettingTile(
                              image: 'assets/images/language.svg',
                              text: 'language'.tr,
                              ontap: () {
                                Get.to(() => TranslateScreen());
                              },
                            ),
                            SettingTile(
                              image: 'assets/images/report.svg',
                              text: 'report_issue'.tr,
                              ontap: () {
                                settingController.clearbugVariables();
                                onBugTAp(context);
                              },
                            ),
                            const SizedBox(height: 40),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 12),
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   width: MediaQuery.of(context).size.width * 0.76,
                              //   padding: const EdgeInsets.only(bottom: 12),
                              //   child: Text(
                              //     'to_see_profile'.tr,
                              //     textAlign: TextAlign.center,
                              //     maxLines: 2,
                              //   ),
                              // ),
                              // LargeButton(
                              //     title: 'Sign_in'.tr,
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //           new MaterialPageRoute(
                              //               builder: (context) =>
                              //                   new LoginScreen(
                              //                       // nextScreen: 'any',
                              //                       )));
                              //     })
                            ],
                          )),
                ],
              ),
            ),
            auth.currentUser != null
                ? Positioned(
                    bottom: 20,
                    child: LargeButton(
                      title: "logout".tr,
                      onPressed: () {
                        logout(context);
                        // settingController.signOut();
                      },
                    ))
                : Container()
          ],
        ),
      )),
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
      title: "are_you_sure_that_you_want_to_logout".tr,
      buttons: [
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          child: Text(
            "yes".tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            authService.logout();
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
            "no".tr,
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

  deleteProfile(context) {
    Alert(
      style: const AlertStyle(
        titleStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
      ),
      context: context,
      image: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SvgPicture.asset('assets/images/logout.svg'),
      ),
      title: "Are you sure that you want to delete user?".tr,
      buttons: [
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          child: Text(
            "yes".tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            authService.deleteUserAccount();
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
            "no".tr,
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
