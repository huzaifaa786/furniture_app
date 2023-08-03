import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/company.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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

      List<Company> fetchedCompanies =
          await Future.wait(querySnapshot.docs.map((doc) async {
        String companyId = doc.id;
        double ratingSum = await fetchCompanyRatingSum(
            companyId); // Fetch rating sum for the company
        print(ratingSum);
        return Company(
          id: companyId,
          companyImage: doc['companyImage1'],
          companyImage1: doc['companyImage2'],
          companyImage2: doc['companyImage3'],
          startTime: (doc['startTime'] as Timestamp).toDate(),
          endTime: (doc['endTime'] as Timestamp).toDate(),
          englishBio: doc['englishBio'],
          arabicBio: doc['arabicBio'],
          name: doc['name'],
          rating: ratingSum, // Add the rating sum to the Company model
        );
      }));

      companies = fetchedCompanies;
      update();
    } catch (e) {
      print('Error fetching companies: $e');
    }
  }

  Future<double> fetchCompanyRatingSum(String companyId) async {
    double sum = 0.0;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('ratings')
          .where('companyId', isEqualTo: companyId)
          .get();

      sum = querySnapshot.docs.fold(
          0.0, (previousValue, doc) => previousValue + (doc['rating'] ?? 0.0));
    } catch (e) {
      print('Error fetching rating sum for company $companyId: $e');
    }
    return sum;
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
