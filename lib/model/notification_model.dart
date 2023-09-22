import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? id;
  String? userId;
  String? companyId;
  String? orderId;
  String? content;
  bool? seen;

  NotificationModel({
    this.id,
    this.userId,
    this.companyId,
    this.orderId,
    this.content,
    this.seen,
  });

  NotificationModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    userId = data['userId'] ?? '';
    id = data["id"] ?? '';
    companyId = data['companyId'] ?? '';
    orderId = data['orderId'] ?? '';
    content = data['content'] ?? '';
    seen = data['seen'];
  }
}
