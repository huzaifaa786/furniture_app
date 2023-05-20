import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture/screen/login/login_controller.dart';
import 'package:furniture/screen/register/signup_controller.dart';
import 'package:furniture/services/auth_service.dart';

SignUpController signUpController = SignUpController.instance;
LoginController loginController = LoginController.instance;
AuthService authService = AuthService.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;