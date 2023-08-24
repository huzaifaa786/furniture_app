// ignore_for_file: prefer__ructors, prefer__literals_to_create_immutables, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/order_model.dart';
import 'package:furniture/screen/order/order_controller.dart';
import 'package:furniture/static/orderStatusTile.dart';
import 'package:furniture/static/topbar.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key, required this.order});
  final OrderModel? order;
  @override
  State<OrderStatusScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OrderStatusScreen> {
  getComapany() {
    orderController.companyFetch(widget.order!.companyId);
  }

  @override
  void initState() {
    getComapany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: GetBuilder<OrderController>(
        builder: (controller) => SafeArea(
            child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TopBar(
                text: 'Status',
                ontap: () {
                  Get.back();
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: widget.order!.status == 0
                      ? SvgPicture.asset('assets/images/orderstatus.svg')
                      : widget.order!.status == 1
                          ? Image.asset('assets/images/status1.png')
                          : widget.order!.status == 2
                              ? Image.asset('assets/images/status2.png')
                              : Image.asset('assets/images/status3.png'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 25.0, left: 20, right: 20, bottom: 30),
                child: widget.order!.status == 0
                    ? Text(
                        'Your order has been confirmed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : widget.order!.status == 1
                        ? Text(
                            'Our Professional is on way.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : widget.order!.status == 2
                            ? Text(
                                'Way to the delivery.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                'Order delivered successfully.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                      padding: EdgeInsets.only(bottom: 25),
                      child: Text(
                        '#' + widget.order!.id!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    OrderStatusTile(
                        title: 'Company Name',
                        discription: orderController.companyName == null
                            ? ''
                            : orderController.companyName),
                    OrderStatusTile(
                        title: 'Date of Service',
                        discription: widget.order!.date),
                    OrderStatusTile(
                        title: 'Time of Service',
                        discription: widget.order!.time),
                    OrderStatusTile(
                        title: 'Order Details',
                        discription: widget.order!.description),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              'Amount',
                              style: const TextStyle(
                                  color: mainColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Text(
                              widget.order!.amount.toString() + ' AED',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500),
                            ),
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
      ),
    );
  }
}
