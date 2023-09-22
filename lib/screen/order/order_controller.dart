import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  String? companyName;
  Stream<List<OrderModel>>? orderStream;

  Stream<List<OrderModel>>? getItemsStream({String? query}) {
    if (query == null || query.isEmpty) {
      orderStream = FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .orderBy('orderId', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromSnapshot(doc))
              .toList());
      update();
      return orderStream;
    } else {
      String queryLower = query.toLowerCase();
      String queryUpper = queryLower.substring(0, queryLower.length - 1) +
          String.fromCharCode(queryLower.codeUnitAt(queryLower.length - 1) + 1);

      orderStream = FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .where('orderId',
              isGreaterThanOrEqualTo: queryLower, isLessThan: queryUpper)
          .orderBy('orderId', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromSnapshot(doc))
              .toList());
      update();
      return orderStream;
    }
  }

  companyFetch(id) async {
    DocumentSnapshot companyData =
        await FirebaseFirestore.instance.collection('companies').doc(id).get();
        print(companyData);
    companyName = companyData.get('name');
    update();
  }
}
