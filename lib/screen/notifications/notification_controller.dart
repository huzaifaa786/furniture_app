import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/constants/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/model/notification_model.dart';
import 'package:furniture/model/order_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  Stream<List<NotificationModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromSnapshot(doc))
            .toList());
  }

  Future<OrderModel?> fetchOrder(String orderId) async {
    try {
      final DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get();

      if (orderSnapshot.exists) {
        final data = orderSnapshot.data() as Map<String, dynamic>;
        return OrderModel(
            id: data['orderId'],
            userId: data['userId'],
            amount: data['amount'],
            companyId: data['companyId'],
            date: data['date'],
            description: data['description'],
            isRating: data['isRating'],
            status: data['status'],
            time: data['time']
            // Map other properties from Firestore to your Order model
            );
      } else {
        return null; // Order not found
      }
    } catch (e) {
      print('Error fetching order: $e');
      return null;
    }
  }

  Future<void> markNotificationAsSeen(String notificationId) async {
    LoadingHelper.show();
    try {
      final DocumentReference notificationRef = FirebaseFirestore.instance
          .collection('notifications')
          .doc(notificationId);

      await notificationRef.update({'seen': true});
      LoadingHelper.dismiss();
    } catch (error) {
      print('Error marking notification as seen: $error');
      LoadingHelper.dismiss();
    }
  }
}
