import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture/screen/chat/controller.dart';
import 'package:furniture/firebase_options.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/screen/home/home_controller.dart';
import 'package:furniture/screen/login/login_controller.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/screen/notifications/notification_controller.dart';
import 'package:furniture/screen/order/order_controller.dart';
import 'package:furniture/screen/register/signup_controller.dart';
import 'package:furniture/screen/setting/setting_controller.dart';
import 'package:furniture/screen/splash_screen/splash_screen.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/values/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoadingHelper.init();
  await Firebase.initializeApp();
  Get.put(LoginController());

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthService());
    // Get.put(NotificationService());
    Get.put(SignUpController());
    Get.put(LoginController());
    Get.put(HomeController());
    Get.put(OrderController());
    Get.put(NotificationController());
    Get.put(SettingController());
    
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
  // @override
  // void initState() async {
  //   final userDoc = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(auth.currentUser!.uid)
  //       .get();
  //   final userData = userDoc.data()! as Map<String, dynamic>;
  //   // var user = User.fromJson(userData);
  //   print(userData['token']);
  //   notificationService.sendNotification(
  //       userData['token'],
  //       "Master Access Card Scanned",
  //       "This microchip id scanned # ");
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
              // firebaseStorage: firebaseStorage,
              ),
        ),
      ],
      child: GetMaterialApp(
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
      ),
    );
  }
}
