// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/order_model.dart';
import 'package:furniture/screen/bottomNavBar/bottomNaviBar.dart';
import 'package:furniture/screen/login/login_screen.dart';
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
  String? search;

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      orderController.getItemsStream(query: '');
    } else {
      Future.delayed(Duration.zero, () {
        setState(() {
          // Your state changes here
          Get.to(() => LoginScreen())!.then((value) {
            Get.offAll(() => BottomNavScreen());
          });
        });
      });
    }
  }

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
                'orders'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                maxLines: null,
              )),
            ),
            auth.currentUser != null
                ? Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      onChanged: (String val) {
                        search = val;
                        orderController.getItemsStream(query: search);
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]!)),
                        hintText: 'search_order'.tr,
                      ),
                    ),
                  )
                : Container(),
            auth.currentUser != null
                ? Flexible(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: StreamBuilder<List<OrderModel>>(
                        stream: orderController
                            .orderStream, // Use the stream you created to fetch data
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            List<OrderModel>? items = snapshot.data;

                            return items!.isNotEmpty
                                ? ListView.builder(
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      OrderModel item = items[index];
                                      return OrderCard(
                                        ontap: () {
                                          orderController.companyName = null;
                                          Get.to(() =>
                                              OrderStatusScreen(order: item));
                                        },
                                        description: item.description,
                                        amount: item.amount.toString(),
                                        id: item.id,
                                      );
                                    },
                                  )
                                : Container(
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14, top: 12),
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.76,
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: Text(
                                            'No orders to be found'.tr,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ));
                          }
                        },
                      ),
                    ),
                  )
                : Container(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, top: 12),
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.76,
                        //   padding: const EdgeInsets.only(bottom: 12),
                        //   child: Text(
                        //     'to_see_order'.tr,
                        //     textAlign: TextAlign.center,
                        //     maxLines: 2,
                        //   ),
                        // ),
                        // LargeButton(
                        //     title: 'Sign_in'.tr,
                        //     onPressed: () {
                        //       Navigator.of(context).push(new MaterialPageRoute(
                        //           builder: (context) => new LoginScreen(
                        //               // nextScreen: 'any',
                        //               )));
                        //     })
                      ],
                    )),
          ],
        ),
      )),
    );
  }
}
