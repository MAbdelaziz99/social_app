import 'dart:io';

import 'package:flutter/material.dart';

bool isIos() {
  if (Platform.isIOS) {
    return true;
  }
  return false;
}

String imagesPath = 'assets/images';

double getScreenHeightWithoutSafeArea(context) => MediaQuery.of(context).size.height -
    AppBar().preferredSize.height -
    MediaQuery.of(context).padding.top -
    MediaQuery.of(context).padding.bottom -
    kBottomNavigationBarHeight;
