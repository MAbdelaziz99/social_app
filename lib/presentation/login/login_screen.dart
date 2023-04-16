import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/presentation/login/cubit/login_cubit.dart';
import 'package:social_app/presentation/login/cubit/login_states.dart';
import 'package:social_app/router/router_const.dart';
import 'package:social_app/shared/components/material_button.dart';
import 'package:social_app/shared/components/size_between_components.dart';
import 'package:social_app/shared/components/text_button.dart';
import 'package:social_app/shared/components/text_form_field.dart';

import '../../shared/components/navigator.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
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
                      SvgPicture.asset(
                        'assets/images/login_icon.svg',
                        width: 200.0.r,
                        height: 200.0.r,
                      ),
                      SizedBox(
                        height: 50.0.h,
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20.0).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextFormField(
                                controller: _emailController,
                                hintText: 'Email',
                                prefixIcon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                errorMsg: 'Please enter your email .',
                              ),
                             sizeBetweenTextFields(),

                              DefaultTextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                hintText: 'Password',
                                prefixIcon: Icons.lock,
                                obscureText:
                                    cubit.isPasswordShown ? false : true,
                                suffixIcon: cubit.isPasswordShown
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                onSuffixIcon: () {
                                  cubit.showPassword();
                                },
                                errorMsg: 'Please enter your password .',
                              ),
                              SizedBox(
                                height: 5.0.h,
                              ),
                              DefaultTextButton(
                                  text: 'Forgot password ? ', onPressed: () {}),
                              SizedBox(
                                height: 5.0.h,
                              ),
                              DefaultButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {}
                                  },
                                  text: 'Login'),
                              SizedBox(
                                height: 5.0.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Aren't you have an account ?",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  DefaultTextButton(
                                      text: "Register", onPressed: () {
                                        navigateTo(context: context, routeName: registerScreen);
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
