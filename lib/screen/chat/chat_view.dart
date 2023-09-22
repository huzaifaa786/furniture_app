import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture/screen/chat/chat_page.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/static/topbar.dart';
import 'package:furniture/values/colors.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class ChatLsitScreen extends StatelessWidget {
  const ChatLsitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                TopBar(
                  ontap: () {
                    Get.back();
                  },
                  text: 'Chatting'.tr,
                ),
                Flexible(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .where('userId', isEqualTo: auth.currentUser!.uid)
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final messagesSnapshot = snapshot.data;
                          return FutureBuilder<List<Map<String, dynamic>>>(
                            future: fetchCompaniesData(messagesSnapshot!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else {
                                final companiesData = snapshot.data;
                                return companiesData!.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: companiesData.length,
                                        itemBuilder: (context, index) {
                                          final companyData =
                                              companiesData[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 2),
                                            child: Container(
                                              height: 97,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(38),
                                                ),
                                                shadows: [
                                                  BoxShadow(
                                                    color: Color(0x21000000),
                                                    blurRadius: 28,
                                                    offset: Offset(2, 2),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: Center(
                                                child: ListTile(
                                                  leading: SizedBox(
                                                    height: 55,
                                                    width: 59,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Container(
                                                        color: mainColor,
                                                        child: Image.network(
                                                          companyData[
                                                              'companyImage1'],
                                                          fit: BoxFit.cover,
                                                        ),
                                                        //  SvgPicture.asset(
                                                        //   'assets/images/profile.svg', // fit: BoxFit.fill,
                                                        // ),
                                                      ),
                                                    ),
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      Container(
                                                        constraints: BoxConstraints(
                                                            maxWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4),
                                                        child: Text(
                                                          companyData['name'],
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0),
                                                        child: badges.Badge(
                                                          showBadge: companyData[
                                                                      'seen'] ==
                                                                  true
                                                              ? false
                                                              : true,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  subtitle: Text(
                                                    companyData['englishBio'],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      fontFamily: 'Mazzard',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  trailing: Icon(
                                                    Icons
                                                        .arrow_circle_right_outlined,
                                                    size: 30,
                                                  ),
                                                  onTap: () {
                                                    Get.to(
                                                      () => ChatPage(
                                                        arguments:
                                                            ChatPageArguments(
                                                          peerId: companyData[
                                                              'companyId'],
                                                          peerAvatar: companyData[
                                                              'companyImage1'],
                                                          peerNickname:
                                                              companyData[
                                                                  'name'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14, top: 12),
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 12),
                                              child: Text(
                                                "No chats found".tr,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ));
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fetch the companies' data

  Future<List<Map<String, dynamic>>> fetchCompaniesData(
      QuerySnapshot messagesSnapshot) async {
    List<Map<String, dynamic>> companyDataWithID = [];

    for (var document in messagesSnapshot.docs) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('companies')
          .doc(document['companyId'])
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic> companyData =
            userSnapshot.data() as Map<String, dynamic>;
        companyData['companyId'] = document['companyId'];
        companyData['seen'] = document['userSeen'];
        companyDataWithID.add(companyData);
      }
    }
    return companyDataWithID;
  }
}
