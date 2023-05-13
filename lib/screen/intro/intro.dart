import 'package:flutter/material.dart';
import 'package:furniture/screen/intro/fragments/fragment_1.dart';
import 'package:furniture/screen/intro/fragments/fragment_2.dart';
import 'package:furniture/screen/intro/fragments/fragment_3.dart';
import 'package:furniture/static/large_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int slideIndex = 0;
  PageController? controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    // child: StepProgressIndicator(
                    //   currentStep: slideIndex + 1,
                    //   totalSteps: 3,
                    //   selectedColor: mainColor,
                    //   unselectedColor: grey,
                    //   selectedSize: 3,
                    //   unselectedSize: 3,
                    //   roundedEdges: Radius.circular(45),
                    // )
                    ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        slideIndex = index;
                      });
                    },
                    children: <Widget>[
                      FragmentOne(controller: controller!),
                      FragmentTwo(controller: controller!),
                      FragmentThree(controller: controller!),
                    ],
                  ),
                ),
                slideIndex == 0
                    ? LargeButton(
                        buttonWidth: 0.75,
                        title: "NEXT",
                        onPressed: () {
                          setState(() {
                            setState(() {
                              slideIndex++;
                              controller!.animateToPage(slideIndex,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            });
                          });
                        },
                      )
                    : slideIndex == 1
                        ? LargeButton(
                            buttonWidth: 0.75,
                            title: "NEXT",
                            onPressed: () {
                              setState(() {
                                setState(() {
                                  slideIndex++;
                                  controller!.animateToPage(slideIndex,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.ease);
                                });
                              });
                            },
                          )
                        : LargeButton(
                            buttonWidth: 0.75,
                            title: "GET STARTED",
                            onPressed: () {
                              Navigator.popAndPushNamed(context, 'login');
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
