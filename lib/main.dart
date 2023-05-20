import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture/firebase_options.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/screen/login/login_controller.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/screen/register/signup_controller.dart';
import 'package:furniture/screen/splash_screen/splash_screen.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/values/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoadingHelper.init();
    Get.put(LoginController());

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthService());
    Get.put(SignUpController());
    Get.put(LoginController());
  });
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(),
      theme: Styles.lightTheme,
      title: "furniture",
      initialRoute: 'login',
      routes: {
        'splash': (_) => const SplashScreen(),
        'login': (_) => const LoginScreen(),
      },
    );
  }
}
