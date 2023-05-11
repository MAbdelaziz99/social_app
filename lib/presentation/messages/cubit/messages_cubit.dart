import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:social_app/data/models/message_model.dart';
import 'package:social_app/presentation/messages/firebase/add_message.dart';
import 'package:social_app/presentation/messages/firebase/delete_message.dart';
import 'package:social_app/presentation/messages/firebase/get_messages.dart';
import 'package:social_app/shared/components/default_alert_dialog.dart';
import 'package:social_app/shared/components/snackbar.dart';
import '../../../data/models/user_model.dart';
import '../../../shared/components/progress_sialog.dart';

part 'messages_states.dart';

class MessagesCubit extends Cubit<MessagesStates> {
  MessagesCubit() : super(MessagesInitialState());

  static MessagesCubit get(context) => BlocProvider.of(context);

  addMessage(
      {required context,
      required UserModel receiverModel,
      required TextEditingController messageController}) {
    FocusManager.instance.primaryFocus?.unfocus();
    ProgressDialog progressDialog =
        defaultProgressDialog(context: context, message: 'Add a message ...');
    progressDialog.show();
    emit(MessagesAddLoadingState());
    AddMessage.getInstance().addMessage(
        receiverModel: receiverModel,
        messageText: messageController.text,
        onSuccessListen: (value) {
          messageController.text = '';
          progressDialog.hide();
          emit(MessagesAddSuccessState());
        },
        onErrorListen: (error) {
          defaultErrorSnackBar(
              title: 'Add Message',
              message: 'Failed to send message. try again');
          progressDialog.hide();
          emit(MessagesAddErrorState());
        });
  }

  List<MessageModel> messages = [];
  List<int> messageIds = [];

  getMessages({
    required UserModel receiverModel,
    required scrollController,
  }) {
    emit(MessagesGetLoadingState());
    GetMessages.getInstance().getMessages(
        onGetSuccessListen: (messageModels) {
          messageIds = [];
          messages = [];
          for (var element in messageModels) {
            messageIds.add(int.parse(element.messageId ?? ''));
          }
          messageIds.sort();
          for (var messageId in messageIds) {
            messageModels
                .where((element) => element.messageId == messageId.toString())
                .forEach((element) {
              messages.add(element);
              if (!isClosed) {
                emit(MessagesGetSuccessState());
              }
            });
          }
          animateToLastItemInMessagesList(scrollController: scrollController);
          if (!isClosed) {
            emit(MessagesGetSuccessState());
          }
        },
        receiverModel: receiverModel);
  }

  deleteMessage({required context, required receiverId, required messageId}) {
    emit(MessagesDeleteLoadingState());
    DeleteMessage.getInstance().deleteMessage(
        receiverId: receiverId,
        messageId: messageId,
        onSuccessListen: (value) {
          defaultSuccessSnackBar(
              title: 'Delete message', message: 'Message has been deleted');
          Navigator.pop(context);
          emit(MessagesDeleteSuccessState());
        },
        onErrorListen: (error) {
          defaultErrorSnackBar(
              title: 'Delete message',
              message: 'Failed to delete this message. try again');
          emit(MessagesDeleteErrorState());
        });
  }

  showMessageDeleteDialog(
      {required context, required MessageModel messageModel}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DefaultAlertDialog(
          titleText: 'Choose an option',
          messageText: 'Are you want to delete  or copy message ?',
          button1Text: 'Delete message',
          button2Text: 'Copy message',
          onPressed1: () {
            deleteMessage(
                context: context,
                receiverId: messageModel.receiverId,
                messageId: messageModel.messageId);
          },
          onPressed2: () {
            copyMessage(
                context: context, messageText: messageModel.messageText);
          }),
    );
  }

  copyMessage({required context, required messageText}) {
    Clipboard.setData(ClipboardData(text: messageText)).then((value) {
      defaultSuccessSnackBar(
          title: 'Message coping', message: 'The message is copied');
      Navigator.pop(context);
    });
  }

  animateToLastItemInMessagesList({required scrollController}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      });
    });
  }
}
