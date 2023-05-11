import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:social_app/data/app_data/user_data.dart';
import 'package:social_app/data/models/message_model.dart';
import 'package:social_app/data/models/user_model.dart';

class AddMessage {
  static AddMessage getInstance() => AddMessage();

  addMessage(
      {required UserModel receiverModel,
      required messageText,
      required messageId,
      required Function(dynamic) onSuccessListen,
      required Function(dynamic) onErrorListen}) {
    var sdf = DateFormat("yyyy-MM-dd HH:mm");
    final String messageTime = sdf.format(DateTime.now());

    MessageModel messageModel = MessageModel(
        messageId: messageId,
        messageText: messageText,
        messageTime: messageTime,
        receiverId: receiverModel.uid,
        senderId: userModel?.uid);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .collection('chats')
        .doc(receiverModel.uid)
        .collection('messages')
        .doc(messageId)
        .set(messageModel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverModel.uid)
          .collection('chats')
          .doc(userModel?.uid)
          .collection('messages')
          .doc(messageId)
          .set(messageModel.toMap())
          .then(onSuccessListen)
          .catchError(onErrorListen);
    });
  }
}
