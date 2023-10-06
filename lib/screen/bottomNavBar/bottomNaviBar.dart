// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, unused_element, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/home/home_screen.dart';
import 'package:furniture/screen/order/orderscreen.dart';
import 'package:furniture/screen/setting/setting.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:furniture/services/auth_service.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> with RouteAware {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int _navigationMenuIndex = 0;
  bool _isScanning = false;

  void _scanQR() {
    setState(() {
      _isScanning = true;
    });
  }

  switchFragment(int index) {
    setState(() {
      _navigationMenuIndex = index;
      _navigationMenuIndex == 0 ? homeController.chatlength : null;
    });
  }

  @override
  void initState() {
    // Get.put(AuthService());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _fragments = [
      const HomeScreen(),
      OrderScreen(),
      const SettingScreen(),
    ];
    return Directionality(
      textDirection: TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          body: SafeArea(
            child: _fragments[_navigationMenuIndex],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: SalomonBottomBar(
                backgroundColor: white,
                currentIndex: _navigationMenuIndex,
                onTap: switchFragment,
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: SvgPicture.asset('assets/images/home.svg',
                        color:
                            _navigationMenuIndex == 0 ? mainColor : Colors.black),
                    title: Text("home".tr),
                    selectedColor: mainColor,
                  ),
    
                  /// Likes
                  SalomonBottomBarItem(
                    icon: SvgPicture.asset('assets/images/clipboard.svg',
                        color:
                            _navigationMenuIndex == 1 ? mainColor : Colors.black),
                    title: Text("orders".tr),
                    selectedColor: mainColor,
                  ),
    
                  /// Profile
                  SalomonBottomBarItem(
                    icon: SvgPicture.asset('assets/images/profile.svg',
                        color:
                            _navigationMenuIndex == 2 ? mainColor : Colors.black),
                    title: Text("profile".tr),
                    selectedColor: mainColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
