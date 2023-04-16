import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/register/cubit/register_cubit.dart';
import 'package:social_app/shared/components/text_button.dart';
import 'package:social_app/shared/components/title_dialog.dart';
import 'package:social_app/shared/style/colors.dart';
import '../../presentation/register/cubit/register_states.dart';

class PhotoPickerDialog extends StatelessWidget {
  const PhotoPickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          title: const DefaultTitleDialog(
            title: 'Pick Image',
          ),
          content: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: double.infinity,
                    child: DefaultTextButton(
                      onPressed: ()
                      {
                        RegisterCubit.get(context).pickPhoto(isCamera: false, context: context);
                      },
                      text: 'Gallery',
                      textColor: darkGreyColor,
                    )),
                SizedBox(
                    width: double.infinity,
                    child: DefaultTextButton(
                      onPressed: () {
                        RegisterCubit.get(context).pickPhoto(isCamera: true, context: context);
                      },
                      text: 'Camera',
                      textColor: darkGreyColor,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
