import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/presentation/chats/cubit/chats_cubit.dart';
import 'package:social_app/presentation/messages/messages_screen.dart';
import 'package:social_app/shared/components/user_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..getUsers(),
      child: BlocConsumer<ChatsCubit, ChatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ChatsCubit cubit = ChatsCubit.get(context);
          double screenHeight = MediaQuery.of(context).size.height -
              MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .padding
                  .top;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chats'),
            ),
            body: DefaultUserItem(
                onItemClick: (index) {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0.r),
                            topRight: Radius.circular(20.0.r)),
                      ),
                      builder: (context) => MessagesScreen(
                            receiverModel: cubit.users[index],
                            screenHeight: screenHeight,
                          ));
                },
                users: cubit.users,
                usersStatus: cubit.userStatus),
          );
        },
      ),
    );
  }
}
