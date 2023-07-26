import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  String? companyName;

  Stream<List<OrderModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .orderBy('orderId', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  }

  companyFetch(id) async {
    DocumentSnapshot companyData =
        await FirebaseFirestore.instance.collection('companies').doc(id).get();
    companyName = companyData.get('name');
    update();
  }
}
