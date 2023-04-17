import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/shared/components/material_button.dart';
import 'package:social_app/shared/components/navigator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: [],
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        elevation: 3.0,
      ),
      body: Center(
        child: DefaultButton(
          text: 'Log out',
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) =>
                navigateToAndRemoveUntil(
                    context: context, routeName: loginScreen));
          },
        ),
      ),
    );
  }
}