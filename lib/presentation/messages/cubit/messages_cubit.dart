import 'package:flutter/cupertino.dart';
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
        messageText: messageController.text,
        onSuccessListen: (value) {
          defaultSuccessSnackBar(
              title: 'Add Message', message: 'Message has been sent');
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

  getMessages({required UserModel receiverModel}) {
    emit(MessagesGetLoadingState());
    GetMessages.getInstance().getMessages(
        onGetSuccessListen: (messageModels) {
          messages = messageModels;
          if (!isClosed) {
            emit(MessagesGetSuccessState());
          }
        },
        receiverModel: receiverModel);
  }
}
