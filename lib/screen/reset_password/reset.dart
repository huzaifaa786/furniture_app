// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/screen/bottomNavBar/bottomNaviBar.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/screen/register/signup_controller.dart';
import 'package:furniture/static/input_field1.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/Validator.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final TextEditingController emailController = TextEditingController();
  String resetMessage = '';

  void resetPassword() async {
    try {
      LoadingHelper.show();
      await auth.sendPasswordResetEmail(email: emailController.text);
      LoadingHelper.dismiss();
      setState(() {
        Get.snackbar('Password reset email sent', '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: white);

        Get.offAll(() => BottomNavScreen());
        emailController.clear();
      });
    } catch (error) {
      LoadingHelper.dismiss();
      setState(() {
        Get.snackbar('Error:', ' $error',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: white);

        // Get.showSnackbar(GetSnackBar(
        //   title: 'Error: $error',
        //   backgroundColor: Colors.red,
        //   duration: Duration(seconds: 2),
        // ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/loginback.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        Image(
                          image: AssetImage("assets/images/123.png"),
                          height: 100,
                          // color: Colors.white,
                        ),
                        Container(width: 40),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: MediaQuery.of(context).size.height * 0.72,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 250, 250),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Column(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Text(
                                'Reset Password',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 16, top: 4),
                              child: InputField1(
                                icon: 'assets/images/email.svg',
                                hint: 'Email Address',
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validator: (field) =>
                                    Validators.emailValidator(field),
                              ),
                            ),
                            LargeButton(
                              title: 'Reset',
                              sreenRatio: 0.9,
                              onPressed: () {
                                setState(() {});
                                resetPassword();
                              },
                              textcolor: Colors.white,
                              buttonWidth: 0.95,
                            ),
                            SizedBox(height: 16.0),
                            Text(resetMessage),
                          ]),
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
