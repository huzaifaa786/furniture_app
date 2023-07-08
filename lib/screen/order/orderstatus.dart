// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/static/orderStatusTile.dart';
import 'package:furniture/static/topbar.dart';
import 'package:furniture/values/colors.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsetsDirectional.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TopBar(
              text: 'Notification',
              ontap: () {},
            ),
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/orderstatus.svg',
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Your order has been confirmed.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: mainColor.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text(
                      '#Ord68292',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  OrderStatusTile(title: 'Company Name', discription: 'XYZ'),
                  OrderStatusTile(
                      title: 'Date of Service', discription: '03/03/23'),
                  OrderStatusTile(
                      title: 'Time of Service', discription: '09:00'),
                  OrderStatusTile(
                      title: 'Order Details', discription: '1 Table \n 3 Chairs'),
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '300 AED',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
