// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture/values/colors.dart';

class FragmentThree extends StatefulWidget {
  const FragmentThree({super.key, required this.controller});
  final PageController controller;
  @override
  State<FragmentThree> createState() => _FragmentThreeState();
}

class _FragmentThreeState extends State<FragmentThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: SizedBox(
            // padding: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/splash3.png',
                  ),
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                Container(
                padding: EdgeInsets.only(top: 12, right: 25, left: 25,bottom : 10),
                child: Text(
                  'Efficient Service',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12, right: 25, left:25,bottom : 8),
                child: Text(
                  "خدمات فعالة",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
              ],
            ),
          ),
        )));
  }
}
