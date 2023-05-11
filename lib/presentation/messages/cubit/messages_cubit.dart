import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:social_app/data/models/message_model.dart';
import 'package:social_app/presentation/messages/firebase/add_message.dart';
import 'package:social_app/presentation/messages/firebase/delete_message.dart';
import 'package:social_app/presentation/messages/firebase/get_messages.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:social_app/shared/style/colors.dart';
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
        messageId: (messages.length + 1).toString(),
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut);
              }
            });
          });
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
      {required context, required receiverId, required messageId}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 10.0.r, vertical: 5.0.r),
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.all(5.0.r),
        iconPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Container(
          color: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 5.0.r),
          height: 20.0.h,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Delete a message',
              style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you want to delete message ?',
              style: TextStyle(
                  fontSize: 14.0.sp,
                  color: blueColor,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 30.0.h,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        deleteMessage(
                            context: context,
                            receiverId: receiverId,
                            messageId: messageId);
                      },
                      child: Text(
                        'Delete message',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
