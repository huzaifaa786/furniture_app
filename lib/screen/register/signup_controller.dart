import 'package:flutter/material.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/values/Validator.dart';
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

  void register() {
    LoadingHelper.show();
    final bool isFormValid =
        Validators.emptyStringValidator(name.text, '') == null &&
            Validators.emailValidator(email.text) == null &&
            Validators.emptyStringValidator(phone.text, '') == null &&
            Validators.emptyStringValidator(password.text, '') == null &&
            Validators.emptyStringValidator(confirmPassword.text, '') == null;
    if (isFormValid) {
      String? error = AuthService.instance.createUserWithEmailAndPassword(
          name.text, email.text, phone.text, password.text) as String?;
      LoadingHelper.dismiss();

      if (error != null) {
        Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          duration: const Duration(seconds: 3),
        ));
        LoadingHelper.dismiss();
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
