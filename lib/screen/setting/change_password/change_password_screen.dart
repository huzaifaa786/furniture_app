// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/setting/setting_controller.dart';
import 'package:furniture/static/input_field1.dart';
import 'package:furniture/static/input_field_pass.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/static/topbar.dart';
import 'package:furniture/values/Validator.dart';
import 'package:get/get.dart';

class ChangePasswordscreen extends StatefulWidget {
  const ChangePasswordscreen({super.key});

  @override
  State<ChangePasswordscreen> createState() => _ChangePasswordscreenState();
}

class _ChangePasswordscreenState extends State<ChangePasswordscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SettingController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(children: [
                TopBar(
                  text: 'Change Password',
                  ontap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                PasswordInputField1(
                  hint: 'Old Password',
                  icon: 'assets/images/lock.svg',
                  obscure: settingController.obscureText,
                  toggle: settingController.toggle,
                  controller: settingController.password,
                  validate: settingController.validatePasswordForm,
                  validator: (field) => Validators.passwordValidator(field),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: PasswordInputField1(
                    hint: 'New Password',
                    icon: 'assets/images/lock.svg',
                    obscure: settingController.obscureText1,
                    toggle: settingController.toggle1,
                    controller: settingController.newpassword,
                    validate: settingController.validatePasswordForm,
                    validator: (field) => Validators.passwordValidator(field),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 40),
                  child: PasswordInputField1(
                    hint: 'Repeat Password',
                    icon: 'assets/images/lock.svg',
                    obscure: settingController.obscureText2,
                    toggle: settingController.toggle2,
                    controller: settingController.confirmPassword,
                    validate: settingController.validatePasswordForm,
                    validator: (field) => Validators.confirmPasswordValidator(
                        settingController.newpassword.text, field),
                  ),
                ),
                LargeButton(
                  title: 'Change',
                  sreenRatio: 0.9,
                  onPressed: () {
                    setState(() {});
                    settingController.updatePassword();
                  },
                  textcolor: Colors.white,
                  buttonWidth: 0.95,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
