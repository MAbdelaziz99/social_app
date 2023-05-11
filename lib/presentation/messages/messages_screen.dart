import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/data/app_data/user_data.dart';
import 'package:social_app/data/models/message_model.dart';
import 'package:social_app/data/models/user_model.dart';
import 'package:social_app/presentation/messages/cubit/messages_cubit.dart';
import 'package:social_app/shared/components/default_sent_text.dart';
import 'package:social_app/shared/components/divider.dart';
import 'package:social_app/shared/components/shimmer/comment_shimmer_item.dart';
import 'package:social_app/shared/components/snackbar.dart';

import '../../shared/components/ErrorPhotoWidget.dart';
import '../../shared/style/colors.dart';

class MessagesScreen extends StatefulWidget {
  final UserModel receiverModel;
  final double screenHeight;

  const MessagesScreen(
      {Key? key, required this.receiverModel, required this.screenHeight})
      : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesCubit()
        ..getMessages(
            receiverModel: widget.receiverModel,
            scrollController: scrollController),
      child: BlocConsumer<MessagesCubit, MessagesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          MessagesCubit cubit = MessagesCubit.get(context);
          return SizedBox(
            height: widget.screenHeight,
            child: Padding(
              padding: EdgeInsets.only(
                  right: 10.0.r,
                  left: 10.0.r,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 5.0.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0).r,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: darkGreyColor,
                            )),
                        Expanded(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(45.0.r),
                                child: CachedNetworkImage(
                                  imageUrl: widget.receiverModel.photo ?? '',
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  width: 45.0.r,
                                  height: 45.0.r,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Center(
                                    child: DefaultErrorPhotoWidget(
                                      size: 45.0.r,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0.w,
                              ),
                              Expanded(
                                child: Text(
                                  widget.receiverModel.name ?? '',
                                  style: TextStyle(
                                      fontSize: 16.0.sp,
                                      color: Colors.black,
                                      overflow: TextOverflow.visible),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const DefaultDivider(),
                  ConditionalBuilder(
                      condition: state is! MessagesGetLoadingState,
                      builder: (context) => Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          var message = cubit.messages[index];
                                          if (message.senderId ==
                                              userModel?.uid) {
                                            return buildMyMessage(
                                                context, message, cubit);
                                          }
                                          return buildMessage(
                                              context, message, cubit);
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 5.0.h,
                                            ),
                                        controller: scrollController,
                                        itemCount: cubit.messages.length)),
                                SizedBox(
                                  height: 10.0.h,
                                ),
                                DefaultSentText(
                                    controller: messageController,
                                    onPressedButton: () {
                                      if (messageController.text.isEmpty) {
                                        defaultErrorSnackBar(
                                            title: 'Add a message',
                                            message: 'Please type a message');
                                      } else {
                                        cubit.addMessage(
                                            context: context,
                                            receiverModel: widget.receiverModel,
                                            messageController:
                                                messageController);
                                      }
                                    },
                                    hintText: 'Type your message ...'),
                              ],
                            ),
                          ),
                      fallback: (context) =>
                          const Expanded(child: DefaultCommentShimmerItem()))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  buildMessage(context, MessageModel messageModel, MessagesCubit cubit) =>
      InkWell(
        onLongPress: () => cubit.showMessageDeleteDialog(
            context: context, messageModel: messageModel),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            width: 3 / 4 * MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10.0.r, horizontal: 20.0.r),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0.r),
                  topStart: Radius.circular(10.0.r),
                  bottomEnd: Radius.circular(10.0.r),
                )),
            child: Text(
              messageModel.messageText ?? '',
              style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.black,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ),
      );

  buildMyMessage(context, MessageModel messageModel, MessagesCubit cubit) =>
      InkWell(
        onLongPress: () => cubit.showMessageDeleteDialog(
            context: context, messageModel: messageModel),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            width: 3 / 4 * MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10.0.r, horizontal: 20.0.r),
            decoration: BoxDecoration(
                color: blueColor.withOpacity(0.4),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0.r),
                  topStart: Radius.circular(10.0.r),
                  bottomStart: Radius.circular(10.0.r),
                )),
            child: Text(
              messageModel.messageText ?? '',
              style: TextStyle(
                fontSize: 16.0.sp,
                color: Colors.black,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ),
      );
}
