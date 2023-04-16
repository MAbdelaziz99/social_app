import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/shared/components/text_form_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0).r,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 60.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 50.0.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                  child: Column(
                    children: [
                      DefaultTextFormField(
                          controller: emailController,
                          hintText: 'Email',
                          prefixIcon: Icons.email,
                          validator: (value) {})
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
