// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:furniture/chat/chat_view.dart';

import 'package:furniture/constants/constants.dart';
import 'package:furniture/screen/company_profile/company_controller.dart';
import 'package:furniture/screen/company_profile/profile.dart';
import 'package:furniture/screen/home/home_controller.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  chatCount() {
    homeController.count();
    setState(() {});
  }

  @override
  void initState() {
    chatCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (homeController) => Scaffold(
                body: SafeArea(
                    child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              radius: 32, // Image radius
                              backgroundImage:
                                  AssetImage('assets/images/splashLogo.png'),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: badges.Badge(
                                    showBadge: homeController.chatlength == 0
                                        ? false
                                        : true,
                                    badgeContent: Text(
                                      homeController.chatlength.toString(),
                                      style: TextStyle(color: white),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => ChatLsitScreen())!
                                            .then((value) {
                                          homeController.count();
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/message.svg',
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/images/notification.svg',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 15, top: 25),
                          child: Text('Hello,',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15, top: 15),
                          child: Text(homeController.loggedInUserName.value,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: homeController.companies.length,
                    itemBuilder: (context, index) {
                      final company = homeController.companies[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: company.companyImage,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                company.name,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: ratingColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text('3'),
                                ],
                              ),
                              trailing: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 30,
                              ),
                              onTap: () {
                                Get.put(CompanyController(company: company));
                                Get.to(() =>
                                        CompanyProfileScreen(company: company))!
                                    .then((value) {
                                  homeController.count();
                                });
                                // Handle the tap on the list item
                                // You can navigate to the detail screen or perform any other action
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ))));
  }
}
