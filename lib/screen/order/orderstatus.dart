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
import 'package:get_storage/get_storage.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key, required this.order});
  final OrderModel? order;
  @override
  State<OrderStatusScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OrderStatusScreen> {
  getComapany() {
    orderController.companyFetch(widget.order!.companyId);
    setState(() {});
  }

  GetStorage box = GetStorage();
  String? localeStr;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      localeStr = await box.read('locale');
      getComapany();
      print(localeStr);
    });
    super.initState();
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: white,
        body: GetBuilder<OrderController>(
          builder: (controller) => SafeArea(
              child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopBar(
                    text: 'status'.tr,
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
                    padding: EdgeInsets.only(
                        top: 25.0, left: 20, right: 20, bottom: 30),
                    child: widget.order!.status == 0
                        ? Text(
                            'Your_order_has_been_confiremed'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : widget.order!.status == 1
                            ? Text(
                                'our_professional_is_on_way'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : widget.order!.status == 2
                                ? Text(
                                    'Way_to_deliver'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    'Order_delivered_successfully'.tr,
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
                            title: 'company_name'.tr,
                            discription: orderController.companyName == null
                                ? ''
                                : orderController.companyName),
                        OrderStatusTile(
                            title: 'date_of_service'.tr,
                            discription: widget.order!.date),
                        OrderStatusTile(
                            title: 'time_of_service'.tr,
                            discription: widget.order!.time),
                        OrderStatusTile(
                            title: 'order_details'.tr,
                            discription: widget.order!.description),
                        Directionality(
                          textDirection: box.read('locale') != 'ar'
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          child: Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    'Amount'.tr,
                                    style: const TextStyle(
                                        color: mainColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  child: Text(
                                    widget.order!.amount.toString() + ' AED',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
