// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/order_model.dart';
import 'package:furniture/screen/home/home_controller.dart';
import 'package:furniture/static/large_button.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class Raating extends StatefulWidget {
  const Raating({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  State<Raating> createState() => _RaatingState();
}

class _RaatingState extends State<Raating> {
  double ratings = 0.0;
  getComapany() {
    homeController.companyFetch(widget.orderModel.companyId);
  }

  @override
  void initState() {
    homeController.companyImage = null;
    homeController.companyName = null;
    getComapany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Wrap(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, top: 25, left: 16, right: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        'Your order with orderId #' +
                            widget.orderModel.id.toString() +
                            ' hase been deliverd by ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: homeController.companyImage == null
                          ? Image(
                              image: AssetImage('assets/images/splashLogo.png'),
                              height: 65,
                              width: 65,
                            )
                          : CachedNetworkImage(
                              imageUrl: homeController.companyImage!,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    homeController.companyName != null
                        ? Text(
                            homeController.companyName!,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        : Text(''),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "How do you rate your experience?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: mainColor,
                      ),
                      onRatingUpdate: (rating) {
                        ratings = rating;
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    LargeButton(
                      title: 'Submit',
                      sreenRatio: 0.8,
                      onPressed: ratings == 0.0
                          ? () {}
                          : () {
                              homeController.storeRating(
                                  widget.orderModel.companyId,
                                  ratings,
                                  widget.orderModel.id);
                            },
                      color: mainColor,
                      textcolor: Colors.white,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
