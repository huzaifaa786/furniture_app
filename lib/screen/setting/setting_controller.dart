import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/model/user_model.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/values/Validator.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();
  bool isgoogle = false;

/////////////////////////////////// Variable of Edit Profile Screen ///////////////////////////////

  RxBool validateEditProfileForm = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<UserModel> userModel = UserModel().obs;

/////////////////////////////////// Variable of Change password Screen ///////////////////////////////

  RxBool validatePasswordForm = false.obs;
  TextEditingController newpassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

/////////////////////////////////// Variable of Bug Report Screen ///////////////////////////////////

  XFile? bugImage = XFile('');
  TextEditingController bugcontroller = TextEditingController();
  String imageUrl = "";

///////
/////////////////////////////////// Function to update the password ///////////////////////////////////
//////

  Future<void> updatePassword() async {
    try {
      LoadingHelper.show();
      final bool isFormValid =
          Validators.passwordValidator(password.text) == null &&
              Validators.passwordValidator(newpassword.text) == null &&
              Validators.confirmPasswordValidator(
                      newpassword.text, confirmPassword.text) ==
                  null;
      if (isFormValid) {
        User user = FirebaseAuth.instance.currentUser!;
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password.text.toString(),
        );

        // Reauthenticate the user with the credential
        await user.reauthenticateWithCredential(credential).then((value) async {
          await user.updatePassword(newpassword.text.toString()).then((value) {
            Get.snackbar('Password Updated Successfully', '',
                snackPosition: SnackPosition.BOTTOM,
                colorText: white,
                backgroundColor: Colors.green);
          }).catchError((e) {
            Get.snackbar('Error updating password:', '',
                snackPosition: SnackPosition.BOTTOM,
                colorText: white,
                backgroundColor: Colors.red);
          });
        });
      } else {
        showErrors();
        LoadingHelper.dismiss();
      }
      LoadingHelper.dismiss();
    } catch (e) {
      LoadingHelper.dismiss();
      Get.snackbar('Error updating password', '',
          snackPosition: SnackPosition.BOTTOM,
          colorText: white,
          backgroundColor: Colors.red);
    }
  }

///////
/////////////////////////////////// Function to Report a Bug To Admin ///////////////////////////////////
//////

  Future<void> selectbugImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      bugImage = image;
      update();
    } else {
      bugImage = XFile('');
    }
  }

  UploadTask uploadFiletoFirebase(File image, String fileName) {
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  void reportBug(void Function(bool) callback) async {
    LoadingHelper.show();
    final bool isFormValid =
        Validators.emptyStringValidator(bugcontroller.text, '') == null;
    if (isFormValid) {
      if (bugImage!.path != '') {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        UploadTask uploadTask =
            uploadFiletoFirebase(File(bugImage!.path), fileName);
        try {
          TaskSnapshot snapshot = await uploadTask;
          imageUrl = await snapshot.ref.getDownloadURL();
          String id = DateTime.now().millisecondsSinceEpoch.toString();
          print(imageUrl);
          await firebaseFirestore.collection('reports').doc(id).set({
            "id": id,
            'description': bugcontroller.text,
            "image": imageUrl,
            "userId": auth.currentUser!.uid,
            'seen': false
          });
          clearbugVariables();
          Get.back();
          LoadingHelper.dismiss();
          return callback(true);
        } on FirebaseException catch (e) {
          LoadingHelper.dismiss();
          print(e);
          return callback(false);
          // Fluttertoast.showToast(msg: e.message ?? e.toString());
        }
      } else {
        LoadingHelper.dismiss();
        Get.snackbar('Select an image To procede further.', '',
            snackPosition: SnackPosition.BOTTOM,
            colorText: white,
            backgroundColor: Colors.red);
      }
    } else {
      LoadingHelper.dismiss();
      Get.snackbar('Empty Textfield!', 'Texfield can not be empty.',
          snackPosition: SnackPosition.BOTTOM,
          colorText: white,
          backgroundColor: Colors.red);
    }
  }
///////
/////////////////////// Function to get and update User by intializing varaible //////////////////////////////
//////

  initializeUserModel(String userID) async {
    try {
      final data = auth.currentUser!.uid;
      userModel.value = await firebaseFirestore
          .collection('users')
          .doc(userID)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));
      update();
      if (data == userID) {
        email.text = userModel.value.email!;
        phone.text =
            userModel.value.phone != null ? userModel.value.phone! : '';
        name.text = userModel.value.name!;
      }
    } on FirebaseException catch (e) {
      Get.snackbar('', e.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: white);
    }
  }

  void updateProfile(void Function(bool) callback) async {
    LoadingHelper.show();
    final bool isFormValid =
        Validators.emptyStringValidator(name.text, '') == null;
    if (isFormValid) {
      var collection = FirebaseFirestore.instance.collection('users');
      collection.doc(auth.currentUser!.uid).update({
        'name': name.text,
      }).then((_) {
        LoadingHelper.dismiss();
        return callback(true);
      }).catchError((error) {
        LoadingHelper.dismiss();
        return callback(false);
      });
    } else {
      LoadingHelper.dismiss();
      showErrors();
    }
  }

/////////////////////////////////// Function to Clear the password Varaible ///////////////////////////////////

  clearPasswordVariable() {
    password.clear();
    newpassword.clear();
    confirmPassword.clear();
    validatePasswordForm = false.obs;
    update();
  }

/////////////////////////////////// Function to Clear the Edit Profile Varaible ///////////////////////////////////

  clearProfileVariable() {
    name.clear();
    phone.clear();
    email.clear();
    validateEditProfileForm = false.obs;
    update();
  }

/////////////////////////////////// Function to Clear the Bug Report Varaible ///////////////////////////////////

  clearbugVariables() {
    bugcontroller.clear();
    bugImage = XFile('');
    imageUrl = '';
    update();
  }

/////////////////////////////////// Function to Show the password screen error ///////////////////////////////////

  void showErrors() {
    validatePasswordForm = true.obs;
    update();
  }

/////////////////////////////////// Function to Show the Edit Profile error ///////////////////////////////////

  void showProfileErrors() {
    validatePasswordForm = true.obs;
    update();
  }

/////////////////////////////////// Function To Logout Current user ///////////////////////////////////

  void signOut() {

    FirebaseAuth.instance.signOut();
    // Get.offAll(() => LoginScreen());
  }

  @override
  void onClose() {
    password.dispose();
    newpassword.dispose();
    confirmPassword.dispose();
    email.dispose();
    name.dispose();
    super.onClose();
  }
}
