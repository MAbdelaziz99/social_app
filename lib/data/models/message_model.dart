class MessageModel {
  String? messageId, messageText, messageTime, receiverId, senderId;

  MessageModel(
      {required this.messageId,
      required this.messageText,
      required this.senderId,
      required this.receiverId,
      required this.messageTime});

  MessageModel.fromJson(Map<String, dynamic>? json) {
    messageId = json?['messageId'];
    messageText = json?['messageText'];
    messageTime = json?['messageTime'];
    receiverId = json?['receiverId'];
    senderId = json?['senderId'];
  }

  Map<String, dynamic> toMap() => {
        'messageId': messageId,
        'messageText': messageText,
        'messageTime': messageTime,
        'receiverId': receiverId,
        'senderId': senderId,
      };
}
