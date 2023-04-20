import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/presentation/comments/cubit/comments_states.dart';
import 'package:social_app/presentation/comments/firebase/add_comment/add_comment.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:social_app/shared/constatnts.dart';
import 'package:social_app/shared/style/colors.dart';

class CommentsCubit extends Cubit<CommentsStates> {
  CommentsCubit() : super(CommentsInitialState());

  static CommentsCubit get(context) => BlocProvider.of(context);

  bool isCommentEmpty = true;

  checkCommentTextIsEmptyOrNot(String value) {
    if (value.isEmpty) {
      isCommentEmpty = true;
    } else {
      isCommentEmpty = false;
    }
    emit(CommentCheckTheTextIsEmptyOrNotState());
  }

  String commentAddingStatus = '';

  addComment(
      {required context,
      required postId,
      required TextEditingController commentController}) {
    // hide keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    emit(CommentAddLoadingState());
    commentAddingStatus = FirebaseStatus.loading.name;
    AddComment.getInstance().addComment(
        postId: postId,
        commentController: commentController,
        onSuccessListen: (value) {
          Navigator.pop(context);
          commentController.text = '';
          Get.snackbar(
            'Add a comment',
            'Comment added successfully',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: greenColor,
          );
          commentAddingStatus = FirebaseStatus.success.name;
          emit(CommentAddSuccessState());
        },
        onErrorListen: (error) {
          defaultErrorSnackBar(
              message: 'Failed to add a comment, try again', title: 'Add a comment');
          commentAddingStatus = FirebaseStatus.error.name;
          emit(CommentAddErrorState());
        });
  }
}
