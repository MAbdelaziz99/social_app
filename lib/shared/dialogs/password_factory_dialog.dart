import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/presentation/login/cubit/login_cubit.dart';
import 'package:social_app/presentation/login/cubit/login_states.dart';

import '../components/text_form_field.dart';
import '../components/title_dialog.dart';
import '../style/colors.dart';

class PasswordFactoryDialog extends StatelessWidget {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PasswordFactoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          title: const DefaultTitleDialog(
            title: 'Password factory',
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0).r,
                  child: Text(
                    'Enter email address to reset password .',
                    style: TextStyle(
                        fontSize: 16.0.sp,
                        color: Colors.black,
                        overflow: TextOverflow.visible),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0).r,
                  child: DefaultTextFormField(
                      controller: _emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.email,
                      errorMsg: 'Please enter email address',
                      keyboardType: TextInputType.emailAddress),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0).r,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 30.0.h,
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if(_formKey.currentState!.validate()) {
                                LoginCubit.get(context).resetPassword(
                                  context: context, email: _emailController.text);
                              }
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                  fontSize: 16.0.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13.0.w,
                      ),
                      Expanded(
                        child: Container(
                          height: 30.0.h,
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 16.0.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
