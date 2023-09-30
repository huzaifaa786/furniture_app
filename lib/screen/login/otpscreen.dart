// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginOtpVerifyScreen extends StatefulWidget {
  const LoginOtpVerifyScreen({super.key});
  @override
  State<LoginOtpVerifyScreen> createState() => _LoginOtpVerifyScreenState();
}

class _LoginOtpVerifyScreenState extends State<LoginOtpVerifyScreen> {
  String? phone;
  final TextEditingController pinController = TextEditingController();

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
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderWidth: 1.5,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: Colors.white,
                          selectedColor: mainColor,
                          selectedFillColor: Colors.white,
                          inactiveFillColor: Colors.white.withOpacity(0.7),
                          inactiveColor: mainColor.withOpacity(0.3),
                          activeColor: mainColor.withOpacity(0.2)),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      enablePinAutofill: true,
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.disabled,
                      onChanged: (String value) {
                        phone = value;
                        print(phone);
                      },
                    ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Border radius of 12
                          ),
                          primary: mainColor, // Background color
                          minimumSize: Size(
                            MediaQuery.of(context).size.width, // Full width
                            55.0, // Height of 55
                          ),
                        ),
                        onPressed: () {
                          print(phone.toString());
                          loginController.verifyPhone(phone.toString());
                        },
                        child: Text(
                          'Verify',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
