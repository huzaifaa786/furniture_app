import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/screen/login/otpscreen.dart';
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
      String? error = await authService.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
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
    phone.clear();
    completePhone = null;
    update();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    phone.clear();
    completePhone = null;
    super.onClose();
  }

  /////////////////////////////google login//////////////////////////////////////////////////////

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  signInwithGoogle() async {
    try {
      LoadingHelper.show();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        LoadingHelper.dismiss();
        print("Sign-in canceled by the user.");
      } else {
        var email = googleSignInAccount.email;
        var name = googleSignInAccount.displayName;
        var methods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (methods.contains('password')) {
          LoadingHelper.dismiss();
          Get.snackbar(
              'Email is already associated with password. So, try that method for login with this email.',
              '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: white);
        } else if (methods.contains('google.com')) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          await _auth.signInWithCredential(credential);
          final token = await FirebaseMessaging.instance.getToken();
          var collection = FirebaseFirestore.instance.collection('users');
          collection.doc(auth.currentUser!.uid).update({
            'token': token,
          });
          LoadingHelper.dismiss();
        } else {
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
            "phone": ''
          });
          LoadingHelper.dismiss();
        }
      }
    } on FirebaseAuthException catch (e) {
      LoadingHelper.dismiss();
      Get.snackbar('Google SignIn Failed', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: mainColor);
    }
  }

  // int? resendtoken;
  // RxString? last2;
  // String verificationid = "";
  // void sendToken() async {
  //   LoadingHelper.show();
  //   // final QuerySnapshot result = await FirebaseFirestore.instance
  //   //     .collection('users')
  //   //     .where('phone', isEqualTo: phone.text)
  //   //     .limit(1)
  //   //     .get();
  //   // final List<DocumentSnapshot> number = result.docs;
  //   // if (number.length == 0) {
  //   //   return;
  //   // }
  //   try {
  //     await auth.verifyPhoneNumber(
  //       timeout: const Duration(minutes: 2),
  //       phoneNumber: phone.text,
  //       verificationCompleted: (PhoneAuthCredential credential) async {},
  //       verificationFailed: (FirebaseAuthException e) {
  //         LoadingHelper.dismiss();
  //         Get.snackbar('Verification failed', e.message!,
  //             snackPosition: SnackPosition.BOTTOM,
  //             backgroundColor: Colors.red,
  //             colorText: mainColor);
  //       },
  //       forceResendingToken: resendtoken,
  //       codeSent: (String verificationId, int? resendToken) {
  //         last2 = phone.text.substring(phone.text.length - 2).obs;
  //         verificationid = verificationId;
  //         resendtoken = resendToken;
  //         LoadingHelper.dismiss();
  //         Get.snackbar('OTP has been successfully send', '',
  //             snackPosition: SnackPosition.BOTTOM,
  //             backgroundColor: Colors.green,
  //             colorText: mainColor);
  //         // if (phone == userController.phone) {

  //         //   Get.to(() => const PhoneVerifyScreen());
  //         // } else {
  //         //   Get.to(() => VerifyScreen(
  //         //         idToken: '',
  //         //       ));
  //         // }
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         verificationid = verificationId;
  //         Get.snackbar('TIMEOUT', '',
  //             snackPosition: SnackPosition.BOTTOM,
  //             backgroundColor: Colors.green,
  //             colorText: mainColor);
  //       },
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar('Verification Failed', e.message!,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: mainColor);
  //   }
  // }
  RxString? last2;
  String? completePhone;
  int? resendtoken;
  String verificationid = "";
  void sendTokenforSignUP() async {
    LoadingHelper.show();
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        timeout: const Duration(minutes: 2),
        phoneNumber: completePhone,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          LoadingHelper.dismiss();
          Get.snackbar('Verification failed', e.message!,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: white);
        },
        forceResendingToken: resendtoken,
        codeSent: (String verificationId, int? resendToken) {
          print(verificationId);
          last2 = completePhone!.substring(completePhone!.length - 3).obs;
          verificationid = verificationId;
          resendtoken = resendToken;
          LoadingHelper.dismiss();
          Get.snackbar('OTP has been successfully send', '',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: white);
          Get.to(() => LoginOtpVerifyScreen());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // verificationid = verificationId;
          // Get.snackbar('TIMEOUT', '',
          //     snackPosition: SnackPosition.BOTTOM,
          //     backgroundColor: Colors.green,
          //     colorText: white);
        },
      );
    } on FirebaseAuthException catch (e) {
      LoadingHelper.dismiss();
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: white);
    }
  }

  String usersCollection = "users";
  void verifyPhone(String phone1) async {
    print(phone1.length.toString() +
        '000000000000001233456**********************************');

    try {
      if (phone1.length == 6) {
        LoadingHelper.show();
        final token = await FirebaseMessaging.instance.getToken();
        var val = await FirebaseFirestore.instance
            .collection('users')
            .where('phone', isEqualTo: completePhone)
            .limit(1)
            .get();
        final List<DocumentSnapshot> number = val.docs;
        await auth
            .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationid,
          smsCode: phone1,
        ))
            .then((value) async {
          String userID = value.user!.uid;
          if (number.isEmpty) {
            await firebaseFirestore
                .collection(usersCollection)
                .doc(userID)
                .set({
              "id": userID,
              'token': token,
              "email": '',
              "name": phone.text,
              "phone": completePhone,
            });
            print('object********************************');
          } else {
            await firebaseFirestore
                .collection(usersCollection)
                .doc(userID)
                .update({
              'token': token,
            });
          }
          // Get.offAll(() => const BottomNavScreen());
        }).onError((error, stackTrace) {
          Get.snackbar('Error!', error.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: white);
          LoadingHelper.dismiss();
        });
        LoadingHelper.dismiss();
      } else {
        Get.snackbar('Error!', 'Plese Enter Complete Code',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: white);
        LoadingHelper.dismiss();
      }
    } on FirebaseAuthException catch (e) {
      LoadingHelper.dismiss();
      Get.snackbar('Error!', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: white);
    }
  }


  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
