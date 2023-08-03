import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/model/company.dart';
import 'package:furniture/model/order_model.dart';
import 'package:furniture/screen/home/rating.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Company> companies = <Company>[].obs;
  RxString loggedInUserName = ''.obs;

  Future<void> fetchLoggedInUserName() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(user.uid).get();

      String name = userSnapshot['name'] ?? '';
      loggedInUserName.value = name;
    }
  }

  Future<void> fetchCompanies() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('companies').get();

      List<Company> fetchedCompanies = querySnapshot.docs.map((doc) {
        return Company(
          id: doc.id,
          companyImage: doc['companyImage1'],
          companyImage1: doc['companyImage2'],
          companyImage2: doc['companyImage3'],
          startTime: (doc['startTime'] as Timestamp).toDate(),
          endTime: (doc['endTime'] as Timestamp).toDate(),
          englishBio: doc['englishBio'],
          arabicBio: doc['arabicBio'],
          name: doc['name'],
        );
      }).toList();

      companies = fetchedCompanies;
      update();
    } catch (e) {
      print('Error fetching companies: $e');
    }
  }


///////////////////////////////// unread chat count function and variable //////////////////////////////////

  int chatlength = 0;
  count() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('messages')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .where('userSeen', isEqualTo: false)
        .get();
    chatlength = querySnapshot.docs.length;
    print('Number of documents: $chatlength');
    update();
  }

////////////////////////////////////// Rating function and variable //////////////////////////////////////
  String? companyName;
  String? companyImage;
  OrderModel? last;

  companyFetch(id) async {
    LoadingHelper.show();
    DocumentSnapshot companyData =
        await FirebaseFirestore.instance.collection('companies').doc(id).get();
    companyName = companyData.get('name');
    companyImage = companyData.get('companyImage1');
    LoadingHelper.dismiss();
    update();
  }

  getItemsStream() async {
    FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .orderBy('orderId', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        DocumentSnapshot item = value.docs.first;
        last = OrderModel.fromSnapshot(item);
        if (last!.status == 3) {
          if (last!.isRating == false) {
            Get.bottomSheet(Raating(orderModel: last!));
          }
        }
      }
    });
  }

  storeRating(companyId, rating, orderId) async {
    try {
      LoadingHelper.show();
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({'isRating': true});
      String ratingId = DateTime.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance.collection('ratings').doc(ratingId).set({
        "id": ratingId,
        'companyId': companyId,
        'rating': rating,
        'orderId': orderId,
      });
      Get.back();
      LoadingHelper.dismiss();
    } catch (e) {
      print('Error occurred while setting data: $e');
    }
  }
}
