import 'package:flutter/material.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:furniture/model/user_model.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/colors.dart';

class LoginOtpVerifyScreen extends StatefulWidget {
  const LoginOtpVerifyScreen({super.key, required this.user});
  final UserModel? user;

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
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset("assets/images/otplogo.png"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Verify Your Phone Number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
                    'Entered the 6 digit code received on your entered number ended with *********' +
                        otpServices.last2.toString() +
                        '.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                    ),
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
                    otpServices.otp = verificationCode;
                    otpServices.verifyPhone();
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
                    otpServices.verifyPhone();
                  },
                  color: greenish,
                  textcolor: Colors.white,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
