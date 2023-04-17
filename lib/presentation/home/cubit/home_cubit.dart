import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/chats/chats_screen.dart';
import 'package:social_app/presentation/home/cubit/home_states.dart';
import 'package:social_app/presentation/notifications/notifications_screen.dart';
import 'package:social_app/presentation/post_creation/post_creation_screen.dart';
import 'package:social_app/presentation/posts/posts_screen.dart';
import 'package:social_app/presentation/profile/profile_screen.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ProfileScreen(),
    const PostsScreen(),
    const PostCreationScreen(),
    const NotificationsScreen(),
    const ChatsScreen(),
  ];


}