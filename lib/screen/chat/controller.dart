import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:furniture/screen/chat/constants.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/model/message_chat.dart';

class ChatProvider {
  UploadTask uploadFile(File image, String fileName) {
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) async {
    await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .set({
      'userId': currentUserId,
      'companyId': peerId,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'userSeen': true,
      'companySeen': false,
    });
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageChat messageChat = MessageChat(
      idFrom: currentUserId,
      idTo: peerId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
    );

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  orderPlacement(String description, int amount, String date, String time,
      String currentUserId, String peerId, String id, String intent) async {
    try {
      LoadingHelper.show();
      await FirebaseFirestore.instance.collection('orders').doc(id).set({
        'orderId': id,
        'userId': currentUserId,
        'companyId': peerId,
        'date': date,
        'time': time,
        'amount': amount,
        'status': 0,
        'description': description,
        'isRating': false,
        'intentId': intent
      });
      LoadingHelper.dismiss();
      return true;
    } catch (e) {
      return false;
    }
  }

  notificationCreated(String content, String currentUserId, String peerId,
      String id, String orderId) async {
    try {
      LoadingHelper.show();
      await FirebaseFirestore.instance.collection('notifications').doc(id).set({
        'id': id,
        'userId': currentUserId,
        'companyId': peerId,
        'content': content,
        'orderId': orderId,
        'seen': false
      });
      LoadingHelper.dismiss();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
  static const location = 2;
  static const bill = 3;
}
