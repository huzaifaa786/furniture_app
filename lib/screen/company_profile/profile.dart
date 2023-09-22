// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/chat/chat_page.dart';
import 'package:furniture/helper/general.dart';
import 'package:furniture/model/company.dart';
import 'package:furniture/screen/company_profile/company_controller.dart';
import 'package:furniture/screen/login/login_screen.dart';
import 'package:furniture/static/headingText.dart';
import 'package:furniture/static/largebutton.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key, required this.company});
  final Company company;

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  int _current = 0;
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GetBuilder<CompanyController>(
        builder: (companyController) => Scaffold(
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
                                  items: companyController.imgList.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                          borderRadius:
                                              BorderRadius.circular(45),
                                          border:
                                              Border.all(color: Colors.grey)),
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
                                  count: 3,
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
                                  child: CachedNetworkImage(
                                    imageUrl: widget.company.companyImage,
                                    fit: BoxFit.cover,
                                    height: 70,
                                    width: 70,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Text(
                                        widget.company.name,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ),
                                    RatingBar.builder(
                                      initialRating:
                                          widget.company.rating == 0.0
                                              ? 5
                                              : widget.company.rating,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 18,
                                      ignoreGestures: true,
                                      // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: mainColor,
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
                        HeadingText(text: 'bio'.tr),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 18),
                          child: Directionality(
                            textDirection: box.read('locale') != 'ar'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            child: Text(
                              box.read('locale') != 'ar'
                                      ? widget.company.englishBio: widget.company.arabicBio,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        HeadingText(text: 'working_hours'.tr),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 18),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: mainColor),
                                    borderRadius: BorderRadius.circular(45)),
                                child:
                                    SvgPicture.asset('assets/images/hours.svg'),
                              ),
                              Directionality(
                                textDirection: box.read('locale') != 'ar'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'from'.tr +
                                        ' ' +
                                        formattedTime(
                                            widget.company.startTime) +
                                        ' ' +
                                        'to'.tr +
                                        ' ' +
                                        formattedTime(widget.company.endTime),
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Colors.black54),
                                  ),
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
                    child: MIconButton(
                        title: "inquire".tr,
                        onPressed: () {
                          if (auth.currentUser != null) {
                            Get.to(
                              () => ChatPage(
                                arguments: ChatPageArguments(
                                  peerId: widget.company.id,
                                  peerAvatar: widget.company.companyImage,
                                  peerNickname: widget.company.name,
                                ),
                              ),
                            );
                          } else {
                            Get.to(() => LoginScreen());
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
