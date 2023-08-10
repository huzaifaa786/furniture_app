// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/screen/bottomNavBar/bottomNaviBar.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends GetxController {
  static AuthService get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  String usersCollection = "users";
  List<String>? providerNames;
  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onInit() {
    print('object*************************');
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    super.onInit();
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const BottomNavScreen());

    if (user == null) {
      print("Authentication providers used: null");
    } else {
      providerNames = user.providerData.map((provider) {
        return provider.providerId;
      }).toList();
      print("Authentication providers used: $providerNames");
    }
  }

  //FUNC
  Future<String?> createUserWithEmailAndPassword(
      String name, String email, String phone, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser.value != null) {
        String userID = firebaseUser.value!.uid;
        final token = await FirebaseMessaging.instance.getToken();
        try {
          await firebaseFirestore.collection(usersCollection).doc(userID).set({
            "id": userID,
            'token': token,
            "email": email.trim(),
            "name": name.trim(),
            "phone": phone.trim(),
          });
        } catch (e) {
          // Handle the error here
          print('Error occurred while setting data: $e');
          // You can also show an error message to the user or perform other actions as needed.
        }
        LoadingHelper.dismiss();
      } else {}
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Signup Failed';
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        String userID = firebaseUser.value!.uid;
        final token = await FirebaseMessaging.instance.getToken();
        try {
          await firebaseFirestore
              .collection(usersCollection)
              .doc(userID)
              .update({
            'token': token,
          });
        } catch (e) {
          // Handle the error here
          print('Error occurred while setting data: $e');
          // You can also show an error message to the user or perform other actions as needed.
        }
        LoadingHelper.dismiss();
      } else {}
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'login failed';
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();

  String? otp = '';
  void verifyPhone() async {
    try {
      if (otp!.length == 6) {
        LoadingHelper.show();
        // final QuerySnapshot result = await FirebaseFirestore.instance
        //     .collection('users')
        //     .where('phone', isEqualTo: loginController.completePhone)
        //     .limit(1)
        //     .get();
        // final List<DocumentSnapshot> number = result.docs;
        // if (number.isEmpty) {
        //   print(number.length);
        //   return;
        // }
        await _auth
            .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: loginController.verificationid,
          smsCode: otp!,
        ))
            .then((value) async {
          String userID = value.user!.uid;
          final token = await FirebaseMessaging.instance.getToken();
          await firebaseFirestore.collection(usersCollection).doc(userID).set({
            "id": userID,
            'token': token,
            "email": '',
            "name": loginController.phone.text,
            "phone": loginController.completePhone,
          });
        });
        otp = '';
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
}
