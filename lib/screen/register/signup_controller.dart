import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/values/Validator.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  RxBool validateSignUpForm = false.obs;
  //TextField Controllers to get data from TextFields
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  //Call this Function from Design & it will do the rest

  void register() async {
    LoadingHelper.show();
    final bool isFormValid =
        Validators.emptyStringValidator(name.text, '') == null &&
            Validators.emailValidator(email.text) == null &&
            Validators.emptyStringValidator(phone.text, '') == null &&
            Validators.emptyStringValidator(password.text, '') == null &&
            Validators.emptyStringValidator(confirmPassword.text, '') == null;
    if (isFormValid) {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email.text);
      if (methods.contains('google.com')) {
        LoadingHelper.dismiss();
        Get.snackbar(
            'Email is already associated with google. So, try that method for login with this email.',
            '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: white);
      } else {
        String? error = await authService.createuserwithemailAndpassword(
            name.text, email.text, phone.text, password.text);
        LoadingHelper.dismiss();

        if (error != null) {
          Get.showSnackbar(GetSnackBar(
            message: error.toString(),
            duration: const Duration(seconds: 3),
          ));
          LoadingHelper.dismiss();
        } else {
          LoadingHelper.dismiss();
          clear();
        }
      }
    } else {
      showErrors();
      LoadingHelper.dismiss();
    }
  }

  clear() {
    email.clear();
    password.clear();
    confirmPassword.clear();
    phone.clear();
    name.clear();
    update();
  }

  void showErrors() {
    validateSignUpForm = true.obs;
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    name.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
