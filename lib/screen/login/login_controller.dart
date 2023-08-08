import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';

import 'package:furniture/services/auth_service.dart';

import 'package:furniture/values/Validator.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  RxBool validateSignInForm = false.obs;

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final phone = TextEditingController();
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
      } else {
        clear();
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

  /////////////////////////////google login//////////////////////////////////////////////////////

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      LoadingHelper.show();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      var email = googleSignInAccount!.email;
      var name =googleSignInAccount.displayName;
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      print(methods);
      // if (methods.contains('google.com')) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      final token = await FirebaseMessaging.instance.getToken();
      var collection = FirebaseFirestore.instance.collection('users');
      collection.doc(auth.currentUser!.uid).set({
        "id": auth.currentUser!.uid,
        'token': token,
        "email": email,
        "name": name,
      });
      LoadingHelper.dismiss();
      // } else {
      //   LoadingHelper.dismiss();
      //   Get.snackbar('This google account is not linked with any account', '',
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.red,
      //       colorText: mainColor);
      // }
    } on FirebaseAuthException catch (e) {
      LoadingHelper.dismiss();
      Get.snackbar('Google SignIn Failed', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: mainColor);
    }
  }
  int? resendtoken;
  RxString? last2;
  String verificationid = "";
   void sendToken() async {
    LoadingHelper.show();
   
  

    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(minutes: 2),
        phoneNumber: phone.text,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          LoadingHelper.dismiss();
          Get.snackbar('Verification failed', e.message!,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: mainColor);
        },
        forceResendingToken: resendtoken,
        codeSent: (String verificationId, int? resendToken) {
          last2 = phone.text.substring(phone.text.length - 2).obs;
          verificationid = verificationId;
          resendtoken = resendToken;
          LoadingHelper.dismiss();
          Get.snackbar('OTP has been successfully send', '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: mainColor);
          if (phone == userController.phone) {
        
            Get.to(() => const PhoneVerifyScreen());
          } else {
            Get.to(() => VerifyScreen(
                  idToken: '',
                ));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationid = verificationId;
          Get.snackbar('TIMEOUT', '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: mainColor);
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Verification Failed', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: mainColor);
    }
  }
}
