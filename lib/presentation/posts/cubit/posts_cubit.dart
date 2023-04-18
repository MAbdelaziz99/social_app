import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/data.dart';
import 'package:social_app/data/models/post_model.dart';
import 'package:social_app/presentation/posts/cubit/posts_states.dart';
import 'package:social_app/presentation/posts/firebase/post_liking.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/posts_getting.dart';
import 'package:social_app/shared/components/snackbar.dart';
import '../../../data/models/user_model.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  Map<String, UserModel> userData = {};
  List<PostModel> posts = [];

  getPosts({required context}) async {
    emit(PostsGetLoadingState());
    PostsGetting postGetting = PostsGetting.getInstance();
    postGetting.getPosts(
      context: context,
        onSuccessListen: () => emit(PostsGetSuccessState()),
        onErrorListen: (error) => emit(PostsGetErrorState()));
  }

  likePost({required context, required index}) {
    PostLiking postLiking = PostLiking.getInstance();
    postLiking.likePost(
        index: index,
        onLikeSuccessListen: () => emit(PostLikeSuccessState()),
        onLikeErrorListen: (error) {
          defaultErrorSnackBar(
              message: 'Failed to like this post, try again', context: context);
          emit(PostLikeErrorState());
        });
  }

  changeSliderIndex({required int itemIndex, required int sliderIndex}){
    sliderIndexes[itemIndex] = sliderIndex;
    emit(PostChangeSliderIndex());
  }
}
