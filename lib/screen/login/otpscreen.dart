// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/colors.dart';

class LoginOtpVerifyScreen extends StatefulWidget {
  const LoginOtpVerifyScreen({super.key});
  @override
  State<LoginOtpVerifyScreen> createState() => _LoginOtpVerifyScreenState();
}

class _LoginOtpVerifyScreenState extends State<LoginOtpVerifyScreen> {
  @override
  void initState() {
    // otpServices.api_Token = widget.user!.apiToken;
    // otpServices.user_id = widget.user!.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // padding: EdgeInsets.only(),
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Enter the 6 digit code received on your registered phone number ending with *********' +
                          loginController.last2.toString() +
                          '.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17, color: Colors.black38),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Image.asset("assets/images/otplogo.png"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: mainColor,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      authService.otp = verificationCode;
                      authService.verifyPhone();
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // Center(
                  //   child: Container(
                  //     width: 70,
                  //     height: 30,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       borderRadius: BorderRadius.circular(5.0),
                  //     ),
                  //     child: Text(
                  //       '00:59',
                  //       style: TextStyle(
                  //         fontSize: 15.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Get.to(() => RegisterScreen());
                  //   },
                  //   child: Center(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text('Not received ? '),
                  //         Text(
                  //           'Resend',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: greenish,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: LargeButton(
                    title: 'Submit',
                    sreenRatio: 0.85,
                    onPressed: () {
                      authService.verifyPhone();
                    },
                    color: mainColor,
                    textcolor: Colors.white,
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
