import 'package:flutter/material.dart';
import 'package:furniture/screen/setting/translation/translate_method.dart';
import 'package:furniture/static/topbar.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key, this.lang});

  final String? lang;

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

enum translateMethod { English, Arabic }

class _TranslateScreenState extends State<TranslateScreen> {
  translateMethod _site = translateMethod.English;
  toggleplan(translateMethod value) {
    setState(() {
      _site = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: TopBar(
                ontap: () {
                  Get.back();
                },
                text: 'Language',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TranslateMethod(
                    title: 'English',
                    groupvalue: _site,
                    value: translateMethod.English,
                    onchaged: () async {
                      await toggleplan(translateMethod.English);
                    },
                  ),
                  TranslateMethod(
                    title: 'Arabic',
                    groupvalue: _site,
                    value: translateMethod.Arabic,
                    onchaged: () async {
                      await toggleplan(translateMethod.Arabic);
                    },
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
