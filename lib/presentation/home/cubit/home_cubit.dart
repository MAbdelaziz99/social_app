import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/presentation/chats/chats_screen.dart';
import 'package:social_app/presentation/home/cubit/home_states.dart';
import 'package:social_app/presentation/home/firebase/user_getting.dart';
import 'package:social_app/presentation/notifications/notifications_screen.dart';
import 'package:social_app/presentation/post_creation/post_creation_screen.dart';
import 'package:social_app/presentation/posts/posts_screen.dart';
import 'package:social_app/presentation/profile/profile_screen.dart';
import 'package:social_app/shared/constatnts.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ProfileScreen(),
    PostsScreen(),
    PostCreationScreen(),
    const NotificationsScreen(),
    const ChatsScreen(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(
          isIos() ? CupertinoIcons.person_alt_circle : Icons.person_pin,
          size: 30.0.r,
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: Icon(
          isIos() ? CupertinoIcons.home : Icons.home,
          size: 30.0.r,
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: Icon(
          isIos() ? CupertinoIcons.add_circled_solid : Icons.add_circle,
          size: 30.0.r,
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.notifications_active_rounded,
          size: 30.0.r,
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: Icon(
          isIos() ? CupertinoIcons.chat_bubble_text_fill : Icons.chat_rounded,
          size: 30.0.r,
        ),
        label: ''),
  ];

  int currentIndex = 1;

  changeBottomNavIndex(index) {
    currentIndex = index;
    emit(HomeChangeBottomNavIndexState());
  }

  getUser() {
    HomeUserGetting homeUserGetting = HomeUserGetting.getInstance();
    homeUserGetting.getUser(onGetUserListen: () {
      emit(HomeGetUserState());
    });
  }
}
