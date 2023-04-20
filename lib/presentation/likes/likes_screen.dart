import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/likes/cubit/likes_cubit.dart';
import 'package:social_app/presentation/likes/cubit/likes_states.dart';
import 'package:social_app/router/screen_arguments.dart';
import 'package:social_app/shared/components/user_item.dart';

class LikesScreen extends StatelessWidget {
  final ScreenArguments screenArguments;

  const LikesScreen({Key? key, required this.screenArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            LikesCubit()..getUsers(likeRef: screenArguments.likesRef),
        child: BlocConsumer<LikesCubit, LikesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LikesCubit cubit = LikesCubit.get(context);
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text('Likes'),
                ),
                body: DefaultUserItem(
                  users: cubit.users,
                  usersStatus: cubit.usersStatus,
                ));
          },
        ));
  }
}
