import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:furniture/services/notification_service.dart';
import 'package:furniture/services/payment_service.dart';
import 'package:furniture/values/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:furniture/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoadingHelper.init();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(SignUpController());
    Get.put(LoginController());
    Get.put(HomeController());
    Get.put(OrderController());
    Get.put(NotificationController());
    Get.put(SettingController());
    Get.put(NotificationService());
    Get.put(PaymentService());
  });
  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = "pk_live_51Nps79Fv6EKl7VTQ13FVBQ8Y6SQHs5o471n7BiUibZwVcyfYqV8YOL5tSI70S5CzbF51apGfu5ZQIqPzC1OGtqPW00SVlPYaU0";
  Stripe.merchantIdentifier = 'merchant.com.ezmove';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GetStorage box = GetStorage();
  String? localeStr;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      localeStr = await box.read('locale');
      print(localeStr);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,    
      child: MultiProvider(
        providers: [Provider<ChatProvider>(create: (_) => ChatProvider())],
        child: GetMaterialApp(
          translations: LocaleString(),
          locale: box.read('locale') != 'ar'
              ? Locale('en', 'US')
              : Locale('ar', 'AE'),
          fallbackLocale: box.read('locale') != 'ar'
              ? Locale('en', 'US')
              : Locale('ar', 'AE'),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          builder: EasyLoading.init(),
          theme: Styles.lightTheme,
          title: "Ezmove",
          initialRoute: 'splash',
          routes: {
            'splash': (_) => const SplashScreen(),
            'login': (_) => const LoginScreen(),
          },
        ),
      ),
    );
  }
}
