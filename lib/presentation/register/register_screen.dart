import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app/presentation/register/cubit/register_cubit.dart';
import 'package:social_app/presentation/register/cubit/register_states.dart';
import 'package:social_app/shared/components/material_button.dart';
import 'package:social_app/shared/components/size_between_components.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:social_app/shared/components/spin_kit.dart';
import 'package:social_app/shared/components/text_form_field.dart';
import 'package:social_app/shared/style/colors.dart';

class RegisterScreen extends StatelessWidget {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Register',
              style: TextStyle(
                  fontSize: 20.0.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0).r,
                    child: Stack(
                      children: [
                        cubit.image == null
                            ? CircleAvatar(
                                radius: 60.r,
                                child: Icon(
                                  Icons.person,
                                  size: 60.0.r,
                                ),
                              )
                            : CircleAvatar(
                                radius: 60.r,
                                backgroundImage: FileImage(cubit.image!),
                              ),
                        Positioned(
                          bottom: -1.h,
                          right: -1.w,
                          child: IconButton(
                            onPressed: () {
                              // pick gallery or camera to put photo
                              if(state is !RegisterLoadingState) {
                                cubit.showImagePickerDialog(context: context);
                              }
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: darkGreyColor,
                              size: 40.r,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 100.0.w,
                            child: RadioListTile(
                              title: Text(
                                "Male",
                                style: TextStyle(fontSize: 16.0.sp),
                              ),
                              value: 'Male',
                              groupValue: cubit.gender,
                              onChanged: (value) {
                                if(state is !RegisterLoadingState) {
                                  cubit.changeGender(gender: value);
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              "Female",
                              style: TextStyle(fontSize: 16.0.sp),
                            ),
                            value: 'Female',
                            groupValue: cubit.gender,
                            onChanged: (value) {
                              if(state is !RegisterLoadingState) {
                                cubit.changeGender(gender: value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0).h,
                      child: Column(
                        children: [
                          DefaultTextFormField(
                              controller: _userNameController,
                              hintText: 'User name',
                              prefixIcon: Icons.person,
                              errorMsg: 'Please enter your user name',
                              keyboardType: TextInputType.name),
                          sizeBetweenTextFields(),
                          DefaultTextFormField(
                              controller: _phoneController,
                              hintText: 'Phone',
                              prefixIcon: Icons.phone,
                              errorMsg: 'Please enter your phone number',
                              keyboardType: TextInputType.phone),
                          sizeBetweenTextFields(),
                          DefaultTextFormField(
                              controller: _emailController,
                              hintText: 'Email',
                              prefixIcon: Icons.email,
                              errorMsg: 'Please enter your email',
                              keyboardType: TextInputType.emailAddress),
                          sizeBetweenTextFields(),
                          DefaultTextFormField(
                              controller: _passwordController,
                              hintText: 'Password',
                              prefixIcon: Icons.lock,
                              errorMsg: 'Please enter your password',
                              suffixIcon: cubit.isPasswordShown
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              onSuffixIcon: () => cubit.showPassword(),
                              obscureText: cubit.isPasswordShown ? false : true,
                              keyboardType: TextInputType.visiblePassword),
                          sizeBetweenTextFields(),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => DefaultButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // account creation

                                    cubit.registerAccount(
                                        context: context,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        userName: _userNameController.text,
                                        phone: _phoneController.text);
                                  }
                                },
                                text: 'Register'),
                            fallback: (context) =>  Center(
                              child: DefaultSpinKit(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
