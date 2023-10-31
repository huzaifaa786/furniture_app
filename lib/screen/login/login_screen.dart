// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/login/login_controller.dart';
import 'package:furniture/screen/register/sign_up.dart';
import 'package:furniture/screen/reset_password/reset.dart';
import 'package:furniture/services/auth_service.dart';
import 'dart:io';
import 'package:furniture/static/input_field1.dart';
import 'package:furniture/static/input_field_pass.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/Validator.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int index = 0;

  getindex(id) async {
    setState(() {
      index = id;
      loginController.clear();
    });
  }

  _launchURLApp() async {
    const url = 'https://terms.ezmoveportal.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/loginback.png",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      child: Center(
                        child: Image(
                          image: AssetImage("assets/images/123.png"),
                          height: 100,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 250, 250, 250),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3))
                                ],
                              ),
                              child: ToggleSwitch(
                                initialLabelIndex: index,
                                labels: const [
                                  'Email',
                                  'OTP',
                                ],
                                totalSwitches: 2,
                                onToggle: (index) {
                                  getindex(index);
                                },
                                borderWidth: 3,
                                radiusStyle: true,
                                fontSize: 15,
                                minWidth: 110,
                                minHeight: 45,
                                cornerRadius: 40,
                                changeOnTap: true,
                                inactiveFgColor: Color.fromARGB(255, 9, 9, 9),
                                activeFgColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                inactiveBgColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                activeBgColor: const [mainColor],
                                activeBorders: [
                                  Border.all(
                                    color: white,
                                    width: 3.0,
                                  ),
                                  Border.all(
                                    color: white,
                                    width: 3.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          index == 0
                              ? Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 4),
                                            child: InputField1(
                                              icon: 'assets/images/email.svg',
                                              hint: 'Email Address',
                                              controller: loginController.email,
                                              type: TextInputType.emailAddress,
                                              validate: loginController
                                                  .validateSignInForm,
                                              validator: (field) =>
                                                  Validators.emailValidator(
                                                      field),
                                            ),
                                          ),
                                          PasswordInputField1(
                                            icon: 'assets/images/lock.svg',
                                            hint: 'Password',
                                            obscure:
                                                loginController.obscureText,
                                            toggle: loginController.toggle,
                                            controller:
                                                loginController.password,
                                            validate: loginController
                                                .validateSignInForm,
                                            validator: (field) =>
                                                Validators.emptyStringValidator(
                                                    field, '*password'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12, bottom: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() => ResetScreen());
                                                  },
                                                  child: Text(
                                                    "Forgot Password?",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          LargeButton(
                                            title: 'Login',
                                            sreenRatio: 0.9,
                                            onPressed: () {
                                              // Get.put(AuthService());
                                              loginController.loginUser();
                                            },
                                            textcolor: Colors.white,
                                            buttonWidth: 0.95,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 40, bottom: 25),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'New User ? ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      signUpController.clear();
                                                      signUpController
                                                              .validateSignUpForm =
                                                          false.obs;
                                                      Get.to(() =>
                                                          RegisterScreen());
                                                    },
                                                    child: Text(
                                                      'Register Now',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: mainColor,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey,
                                                  height: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Text(
                                                  'Or login with',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18,
                                                      color: Colors.black54),
                                                ),
                                              ),
                                              Expanded(
                                                child: Divider(
                                                  color: Colors.grey,
                                                  height: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 25, bottom: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    loginController
                                                        .signInwithGoogle();
                                                  },
                                                  child: Image.asset(
                                                      "assets/images/google.png",
                                                      height: 34),
                                                ),
                                                Platform.isIOS
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 12,
                                                                right: 12),
                                                        child: InkWell(
                                                           onTap: () {
                                                            loginController
                                                                .signInWithApple();
                                                          },
                                                          child: Image.asset(
                                                              "assets/images/apple.png",
                                                              height: 34),
                                                        ))
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'By continuing, you accept the',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                InkWell(
                                                  onTap: _launchURLApp,
                                                  child: Text(
                                                    ' Terms of use and Privacy policy',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                                // Text(
                                                //   ' and',
                                                //   style:
                                                //       TextStyle(fontSize: 12),
                                                // ),
                                                // InkWell(
                                                //   onTap: _launchURLApp,
                                                //   child: Text(
                                                //     ' Privcy poliy',
                                                //     style: TextStyle(
                                                //       fontWeight:
                                                //           FontWeight.w600,
                                                //       decoration: TextDecoration
                                                //           .underline,
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 30),
                                          child: Text(
                                            'Back to Account',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Container(
                                            height: 75,
                                            child: IntlPhoneField(
                                              style: TextStyle(fontSize: 14),
                                              controller: loginController.phone,
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 0.5),
                                                hintStyle:
                                                    TextStyle(fontSize: 12),
                                                filled: true,
                                                fillColor: white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              initialCountryCode: 'AE',
                                              onChanged: (phone) {
                                                if (countries
                                                        .firstWhere((element) =>
                                                            element.code ==
                                                            phone
                                                                .countryISOCode)
                                                        .maxLength ==
                                                    phone.number.length) {
                                                  loginController
                                                          .completePhone =
                                                      phone.completeNumber;
                                                } else {
                                                  loginController
                                                      .completePhone = null;
                                                }
                                              },
                                              keyboardType: TextInputType.phone,
                                            ),
                                          ),
                                        ),
                                        LargeButton(
                                          title: 'Request OTP',
                                          sreenRatio: 0.9,
                                          onPressed: () {
                                            if (loginController.completePhone ==
                                                null) {
                                            } else {
                                              loginController
                                                  .sendTokenforSignUP();
                                            }
                                          },
                                          textcolor: Colors.white,
                                          buttonWidth: 0.95,
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(top: 40),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       Expanded(
                                        //         child: Divider(
                                        //           color: Colors.grey,
                                        //           height: 1,
                                        //         ),
                                        //       ),
                                        //       Padding(
                                        //         padding: EdgeInsets.symmetric(
                                        //             horizontal: 10),
                                        //         child: Text(
                                        //           'Or login with',
                                        //           style: TextStyle(
                                        //               fontWeight: FontWeight.w500,
                                        //               fontSize: 18,
                                        //               color: Colors.black54),
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: Divider(
                                        //           color: Colors.grey,
                                        //           height: 1,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       top: 25, bottom: 20),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       Image.asset("assets/images/google.png",
                                        //           height: 34),
                                        //       Padding(
                                        //           padding: EdgeInsets.only(
                                        //               left: 12, right: 12)),
                                        //       Image.asset("assets/images/apple.png",
                                        //           height: 34),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
