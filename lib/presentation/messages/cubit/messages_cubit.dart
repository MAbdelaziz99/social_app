import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:social_app/data/models/message_model.dart';
import 'package:social_app/presentation/messages/firebase/add_message.dart';
import 'package:social_app/presentation/messages/firebase/get_messages.dart';
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
                scrollController.animateTo(scrollController.position.maxScrollExtent,
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
}
