// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture/values/colors.dart';

class FragmentOne extends StatefulWidget {
  const FragmentOne({super.key, required this.controller});
  final PageController controller;

  @override
  State<FragmentOne> createState() => _FragmentOneState();
}

class _FragmentOneState extends State<FragmentOne> {
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
                  'assets/images/splash1.png',
                ),
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              Container(
                padding: EdgeInsets.only(top: 12, right: 25, left: 25,bottom : 10),
                child: Text(
                  'Connecting you with a variety of moving companies',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12, right: 25, left:25,bottom : 8),
                child: Text(
                  "نوصلك بعدة شركات نقل",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
            ],
                  ),
                ),
          )),
    );
  }
}
