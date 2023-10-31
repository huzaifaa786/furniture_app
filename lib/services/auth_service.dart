// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/screen/bottomNavBar/bottomNaviBar.dart';
import 'package:furniture/screen/home/home_screen.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

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
    homeController.refresh();
    user == null
        ? Get.offAll(() => const BottomNavScreen())
        : Get.offAll(() => const BottomNavScreen());
    print('user*********************');
    print(user);
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
  Future<String?> createuserwithemailAndpassword(
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
        LoadingHelper.dismiss();

          return null;
        } catch (e) {
          // Handle the error here
          print('Error occurred while setting data: $e');
        LoadingHelper.dismiss();
        return e.toString();
          // You can also show an error message to the user or perform other actions as needed.
        }
      } else {}
    } on FirebaseAuthException catch (e) {
      LoadingHelper.dismiss();
      return e.message;
    }
  }

  Future<void> logout() async {
    homeController.clear();
    homeController.refresh();
    Get.updateLocale(const Locale('en', 'US'));
    GetStorage box = GetStorage();
    await box.write('locale', 'en');
    box.read('locale');
    await _auth.signOut();
  }

  // String? otp = '';

}
