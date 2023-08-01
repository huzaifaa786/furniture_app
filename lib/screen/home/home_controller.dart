import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/company.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Company> companies = <Company>[].obs;
  RxString loggedInUserName = ''.obs;

  @override
  void onInit() {
    super.onInit(); 
  }

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

  int chatlength = 0;
  count() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('messages')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .where('userSeen', isEqualTo: false)
        .get();
    // Get the length of the document list
    chatlength = querySnapshot.docs.length;
    // Now, you can use the 'length' variable as needed
    print('Number of documents: $chatlength');
    update();
  }
}
