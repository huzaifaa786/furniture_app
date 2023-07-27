// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/screen/setting/setting_controller.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class SucessModel extends StatefulWidget {
  const SucessModel({super.key});

  @override
  State<SucessModel> createState() => _SucessModelState();
}

class _SucessModelState extends State<SucessModel> {
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
                    padding: const EdgeInsets.only(top: 0, bottom: 20),
                    child: SvgPicture.asset('assets/images/tick.svg')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Issue Reported\nSuccessfully',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.54,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'ok',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainColor),
                      fixedSize: MaterialStateProperty.all(Size(238, 50)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ));
  }
}
