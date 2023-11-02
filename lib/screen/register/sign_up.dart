// ignore_for_file: prefer_const_constructors, deprecated_member_use, override_on_non_overriding_member

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/register/signup_controller.dart';
import 'package:furniture/static/input_field1.dart';
import 'package:furniture/static/input_field_pass.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/Validator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int index = 0;

  getindex(id) async {
    setState(() {
      index = id;
    });
  }

  @override
  _launchURLApp() async {
    const url = 'https://terms.ezmoveportal.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (homeController) => Scaffold(
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
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              InputField1(
                                hint: 'Username',
                                icon: 'assets/images/user.svg',
                                controller: signUpController.name,
                                validate: signUpController.validateSignUpForm,
                                validator: (field) =>
                                    Validators.emptyStringValidator(
                                        field, '*username '),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 4, top: 4),
                                child: InputField1(
                                  icon: 'assets/images/email.svg',
                                  hint: 'Email Address',
                                  controller: signUpController.email,
                                  type: TextInputType.emailAddress,
                                  validate: signUpController.validateSignUpForm,
                                  validator: (field) =>
                                      Validators.emailValidator(field),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: InputField1(
                                  hint: 'Phone Number',
                                  icon: 'assets/images/phone.svg',
                                  controller: signUpController.phone,
                                  type: TextInputType.number,
                                  validate: signUpController.validateSignUpForm,
                                  validator: (field) =>
                                      Validators.emptyStringValidator(
                                          field, '*phone'),
                                ),
                              ),
                              PasswordInputField1(
                                icon: 'assets/images/lock.svg',
                                hint: 'Password',
                                obscure: signUpController.obscureText,
                                toggle: signUpController.toggle,
                                controller: signUpController.password,
                                validate: signUpController.validateSignUpForm,
                                validator: (field) =>
                                    Validators.emptyStringValidator(
                                        field, '*password'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 20),
                                child: PasswordInputField1(
                                  hint: 'Confirm Password',
                                  icon: 'assets/images/lock.svg',
                                  obscure: signUpController.obscureText1,
                                  toggle: signUpController.toggle1,
                                  controller: signUpController.confirmPassword,
                                  validate: signUpController.validateSignUpForm,
                                  validator: (field) =>
                                      Validators.confirmPasswordValidator(
                                          signUpController.password.text,
                                          field),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'By continuing, you accept the ',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      TextSpan(
                                        text: 'Terms of use and Privacy policy',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = _launchURLApp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              LargeButton(
                                title: 'Sign Up',
                                sreenRatio: 0.9,
                                onPressed: () {
                                  setState(() {});
                                  signUpController.register();
                                },
                                textcolor: Colors.white,
                                buttonWidth: 0.95,
                              ),
                            ]),
                          ),
                        ))
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
