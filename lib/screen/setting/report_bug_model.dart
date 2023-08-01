// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/setting/setting_controller.dart';
import 'package:furniture/screen/setting/success_model.dart';
import 'package:furniture/static/buginput.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BugReportModal extends StatefulWidget {
  const BugReportModal({super.key});

  @override
  State<BugReportModal> createState() => _BugReportModalState();
}

class _BugReportModalState extends State<BugReportModal> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 12),
                  child: Text(
                    'Report Issue',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BugInput(
                      controller: settingController.bugcontroller,
                      text: 'Write issue',
                      maxlines: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      settingController.selectbugImage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: settingController.bugImage!.path == ''
                              ? Icon(Icons.folder_outlined)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.file(
                                      File(settingController.bugImage!.path),
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.cover),
                                ),
                        ),
                        Text('Attach Photo'),
                      ],
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black.withOpacity(0.6499999761581421)),
                      fixedSize: MaterialStateProperty.all(Size(238, 45)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      settingController.reportBug((success) {
                        if (success) {
                          successModel(context);
                        }
                      });
                    },
                    child: Text('Submit'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainColor),
                      fixedSize: MaterialStateProperty.all(Size(238, 45)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }

  successModel(context) {
    Alert(
        context: context,
        content: SucessModel(
          text: 'Issue Reported\nSuccessfully',
        ),
        buttons: [
          DialogButton(
              height: 0, color: white, onPressed: () async {}, child: Text(''))
        ]).show();
  }
}
