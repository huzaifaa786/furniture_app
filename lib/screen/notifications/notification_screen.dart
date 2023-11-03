import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/model/notification_model.dart';
import 'package:furniture/model/order_model.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/screen/order/orderstatus.dart';
import 'package:badges/badges.dart' as badges;
import 'package:furniture/static/topbar.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TopBar(
                text: 'Notification'.tr,
                ontap: () {
                  Get.back();
                },
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: StreamBuilder<List<NotificationModel>>(
                    stream: notificationController
                        .getItemsStream(), // Use the stream you created to fetch data
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return Column(
                          children: [
                            SvgPicture.asset(
                              'assets/images/bell.svg',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Currently, you have no new notifications. Please make an order.'
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        List<NotificationModel>? items = snapshot.data;
                        return items!.isEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/bell.svg',
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Text(
                                              'Currently, you have no new notifications. Please make an order.'
                                                  .tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  NotificationModel item = items[index];
                                  int milliseconds = int.parse(item.id!);
                                  print(item.id);
                                  DateTime dateTime =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          milliseconds);
                                  String formattedDate =
                                      DateFormat('HH:mm yyyy-MM-dd')
                                          .format(dateTime);
                                  return InkWell(
                                    onTap: () async {
                                      LoadingHelper.show();
                                      await notificationController
                                          .markNotificationAsSeen(item.id!);
                                      // Inside the current screen
                                      final OrderModel? order =
                                          await notificationController
                                              .fetchOrder(
                                                  item.orderId.toString());
                                      LoadingHelper.dismiss();
                                      if (order != null) {
                                        Get.to(
                                          () => OrderStatusScreen(order: order),
                                        );
                                      } else {
                                        // Handle the case where the order was not found
                                      }
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                  ),
                                                  color: mainColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: item.content ==
                                                        'Your order has been confirmed.'
                                                    ? SvgPicture.asset(
                                                        'assets/images/noti1.svg',
                                                      )
                                                    : item.content ==
                                                            'Our Professional is on way.'
                                                        ? SvgPicture.asset(
                                                            'assets/images/noti2.svg',
                                                          )
                                                        : item.content ==
                                                                'Way to the delivery.'
                                                            ? SvgPicture.asset(
                                                                'assets/images/noti3.svg',
                                                              )
                                                            : SvgPicture.asset(
                                                                'assets/images/noti4.svg',
                                                              ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.62,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                          child: Text(
                                                            item.content ==
                                                                    'Your order has been confirmed.'
                                                                ? 'Your_order_has_been_confiremed'
                                                                    .tr
                                                                : item.content ==
                                                                        'Our Professional is on way.'
                                                                    ? 'our_professional_is_on_way'
                                                                        .tr
                                                                    : item.content ==
                                                                            'Way to the delivery.'
                                                                        ? 'Way_to_deliver'
                                                                            .tr
                                                                        : 'Order_delivered_successfully'
                                                                            .tr,
                                                            maxLines: null,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: badges.Badge(
                                                            showBadge:
                                                                item.seen ==
                                                                        true
                                                                    ? false
                                                                    : true,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .watch_later_outlined,
                                                          size: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 2),
                                                          child: Text(
                                                              formattedDate,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      10)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
