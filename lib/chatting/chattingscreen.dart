import 'package:flutter/material.dart';
import 'package:furniture/static/topbar.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChattingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TopBar(
              text: 'Chatting',
              ontap: () {},
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 5.0, // Soften the shaodw
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'assets/images/loginback.png',
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Company Name',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text('You: Lorem ipsum dolor sit amet.',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600))
                    ],
                  ),
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
             Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5.0, // Soften the shaodw
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ]),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.asset(
                  'assets/images/loginback.png',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Company Name',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text('You: Lorem ipsum dolor sit amet.',
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w600))
                ],
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
            ],
              ),
            ),
             Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5.0, // Soften the shaodw
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ]),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.asset(
                  'assets/images/loginback.png',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Company Name',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text('You: Lorem ipsum dolor sit amet.',
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w600))
                ],
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
            ],
              ),
            ),
             Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5.0, // Soften the shaodw
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ]),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.asset(
                  'assets/images/loginback.png',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Company Name',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text('You: Lorem ipsum dolor sit amet.',
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w600))
                ],
              ),
              Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
            ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
