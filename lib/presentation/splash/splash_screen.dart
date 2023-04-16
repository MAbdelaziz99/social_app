import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/shared/components/navigator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 1500), (){
      navigateToAndRemoveUntil(context: context, routeName: loginScreen);
    });
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/splash_background.jpg'), fit: BoxFit.fill),
        ),
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0).r,
            child: DefaultTextStyle(
              style:TextStyle(
                fontSize: 30.0.sp,
                color: Colors.grey[900],
                fontWeight: FontWeight.bold
              ) ,
              child: const Text(
                'Social App',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
