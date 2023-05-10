import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/app_data/user_data.dart';
import 'package:social_app/data/models/message_model.dart';
import 'package:social_app/data/models/user_model.dart';

class GetMessages {
  static GetMessages getInstance() => GetMessages();

  getMessages(
      {required Function(List<MessageModel> messages) onGetSuccessListen,
      required UserModel receiverModel}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .collection('chats')
        .doc(receiverModel.uid)
        .collection('messages')
        .orderBy('messageId')
        .snapshots()
        .listen((event) {
      List<MessageModel> messages = [];
      for (var element in event.docs) {
        MessageModel messageModel = MessageModel.fromJson(element.data());
        messages.add(messageModel);
      }
      onGetSuccessListen(messages);
    });
  }
}
