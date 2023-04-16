import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/shared/components/navigator.dart';
import 'package:social_app/shared/components/spin_kit.dart';
import 'package:social_app/shared/style/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 2000), () {
      if (FirebaseAuth.instance.currentUser?.uid == null) {
        navigateToAndRemoveUntil(context: context, routeName: loginScreen);
      } else {
        navigateToAndRemoveUntil(context: context, routeName: homeScreen);
      }
    });
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splash_background.jpg'),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultSpinKit(
              size: 40.0.r,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0, top: 50.0).r,
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 30.0.sp,
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold),
                child: const Text(
                  'Social App',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
