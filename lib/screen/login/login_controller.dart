import 'package:flutter/material.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/values/Validator.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  RxBool validateSignInForm = false.obs;

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> loginUser() async {
    LoadingHelper.show();
    final bool isFormValid = Validators.emailValidator(email.text) == null &&
        Validators.emptyStringValidator(password.text, '') == null;
    if (isFormValid) {
      String? error = await AuthService.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      LoadingHelper.dismiss();
      if (error != null) {
        Get.showSnackbar(GetSnackBar(
          message: error.toString(),
          duration: const Duration(seconds: 3),
        ));
      }
    }
    LoadingHelper.dismiss();
  }

  clear() {
    email.clear();
    password.clear();
    update();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
