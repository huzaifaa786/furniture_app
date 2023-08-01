// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture/screen/register/signup_controller.dart';
import 'package:furniture/static/input_field1.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/Validator.dart';
import 'package:get/get.dart';

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
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/images/splashLogo.png"),
                        height: 100,
                      ),
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
                              padding: const EdgeInsets.only(top: 30, bottom: 30),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ),
                            InputField1(
                              hint: 'Username',
                              icon: 'assets/images/user.svg',
                              controller: controller.name,
                              validate: controller.validateSignUpForm,
                              validator: (field) =>
                                  Validators.emptyStringValidator(
                                      field, '*username '),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4, top: 4),
                              child: InputField1(
                                icon: 'assets/images/email.svg',
                                hint: 'Email Address',
                                controller: controller.email,
                                type: TextInputType.emailAddress,
                                validate: controller.validateSignUpForm,
                                validator: (field) =>
                                    Validators.emailValidator(field),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: InputField1(
                                hint: 'Phone Number',
                                icon: 'assets/images/phone.svg',
                                controller: controller.phone,
                                type: TextInputType.number,
                                validate: controller.validateSignUpForm,
                                validator: (field) =>
                                    Validators.emptyStringValidator(
                                        field, '*phone'),
                              ),
                            ),
                            InputField1(
                              hint: 'Password',
                              icon: 'assets/images/lock.svg',
                              obscure: true,
                              controller: controller.password,
                              validate: controller.validateSignUpForm,
                              validator: (field) =>
                                  Validators.passwordValidator(field),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 20),
                              child: InputField1(
                                hint: 'Confirm Password',
                                icon: 'assets/images/lock.svg',
                                obscure: true,
                                controller: controller.confirmPassword,
                                validate: controller.validateSignUpForm,
                                validator: (field) =>
                                    Validators.confirmPasswordValidator(
                                        controller.password.text, field),
                              ),
                            ),
                            LargeButton(
                              title: 'Sign Up',
                              sreenRatio: 0.9,
                              onPressed: () {
                                setState(() {});
                                controller.register();
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
    );
  }
}
