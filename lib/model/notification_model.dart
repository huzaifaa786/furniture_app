import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? id;
  String? userId;
  String? companyId;
  String? orderId;
  String? content;

  OrderModel({
    this.id,
    this.userId,
    this.companyId,
    this.orderId,
    this.content,
  });

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    userId = data['userId'] ?? '';
    id = data["id"] ?? '';
    companyId = data['companyId'] ?? '';
    orderId = data['orderId'] ?? '';
    content = data['content'] ?? '';
  }
}
