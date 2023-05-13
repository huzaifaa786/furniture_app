import 'package:flutter/material.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/screen/splash_screen/splash_screen.dart';
import 'package:furniture/values/styles.dart';

void main() async {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Styles.lightTheme,
      title: "translation",
      initialRoute: 'splash',
      routes: {
        'splash': (_) => const SplashScreen(),
        'login': (_) => const LoginScreen(),
      },
    );
  }
}
