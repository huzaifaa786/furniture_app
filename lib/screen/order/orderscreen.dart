// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/order_model.dart';
import 'package:furniture/screen/order/order_card.dart';
import 'package:furniture/screen/order/order_controller.dart';
import 'package:furniture/screen/order/orderstatus.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<OrderController>(
        builder: (controller) => Column(
          children: [
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Center(
                  child: Text(
                'Orders',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                maxLines: null,
              )),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  hintText: 'Search order',
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: StreamBuilder<List<OrderModel>>(
                  stream: orderController
                      .getItemsStream(), // Use the stream you created to fetch data
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<OrderModel>? items = snapshot.data;

                      return ListView.builder(
                        itemCount: items!.length,
                        itemBuilder: (context, index) {
                          OrderModel item = items[index];
                          return OrderCard(
                            ontap: () {
                              orderController.companyName = null;
                              Get.to(() => OrderStatusScreen(order: item));
                            },
                            description: item.description,
                            amount: item.amount.toString(),
                            id: item.id,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
