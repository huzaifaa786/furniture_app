// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/model/company.dart';
import 'package:furniture/static/headingText.dart';
import 'package:furniture/static/largebutton.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key, required this.company});
  final Company company;

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  int _current = 0;
  List<String> imgList = [
    'https://cdn.shopify.com/s/files/1/0891/4784/articles/Top_12_Furniture_Store_in_Calgary_1024x1024.jpg?v=1663218020',
    'https://cdn.shopify.com/s/files/1/0891/4784/articles/Top_12_Furniture_Store_in_Calgary_1024x1024.jpg?v=1663218020',
    'https://cdn.shopify.com/s/files/1/0891/4784/articles/Top_12_Furniture_Store_in_Calgary_1024x1024.jpg?v=1663218020',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 200,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1,
                                enlargeCenterPage: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: imgList.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: i,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              left: 10,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(45),
                                      border: Border.all(color: Colors.grey)),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 18,
                                  ),
                                ),
                              )),
                          Positioned(
                            bottom: 24,
                            right: 115,
                            child: CarouselIndicator(
                              count: imgList.length,
                              index: _current,
                              activeColor: Colors.white,
                              color: Colors.white60,
                              width: 40,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 20),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10), // Image border
                            child: Image.asset(
                              'assets/images/loginback.png',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    widget.company.name,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating: widget.company.starRating,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 18,
                                  ignoreGestures: true,
                                  // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: ratingColor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    // print(rating);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    HeadingText(text: 'Bio'),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 18),
                      child: Text(
                        'Lorem ipsum dolor sit amet consectetur. Dapibus velit tellus egestas felis integer facilisi pellentesque a. Molestie vitae potenti amet pharetra faucibus enim. Mattis nulla sapien lorem tortor etiam. Cras lacus odio tincidunt vel blandit sapien phasellus ipsum si.',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black54),
                      ),
                    ),
                    HeadingText(text: 'Working Hours'),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 18),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: mainColor),
                                borderRadius: BorderRadius.circular(45)),
                            child: SvgPicture.asset('assets/images/hours.svg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'From ' + '9:00' + ' To ' + '05:00',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  child: MIconButton(title: "Inquire", onPressed: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
