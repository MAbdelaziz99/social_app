import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/app_data/user_data.dart';

class DeleteMessage {
  static DeleteMessage getInstance() => DeleteMessage();

  deleteMessage({
    required receiverId,
    required messageId,
    required Function(dynamic) onSuccessListen,
    required Function(dynamic) onErrorListen,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uid)
        .collection('messages')
        .doc(messageId)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel?.uid)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .doc(messageId)
          .delete()
          .then(onSuccessListen)
          .catchError(onErrorListen);
    });
  }
}
