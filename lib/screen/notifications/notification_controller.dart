import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/model/order_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  Stream<List<OrderModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  }
}
