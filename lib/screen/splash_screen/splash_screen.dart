// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:furniture/screen/intro/intro.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  void goto() async {
    await Future.delayed(const Duration(seconds: 5));
    bool firstRun = await IsFirstRun.isFirstRun();
    firstRun == true ? Get.off(IntroScreen()) : Get.put(AuthService());
  }
}

initScreen(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SizedBox(
      width: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Image(image: AssetImage("assets/images/splashLogo.png"))
        ],
      ),
    ),
  );
}
