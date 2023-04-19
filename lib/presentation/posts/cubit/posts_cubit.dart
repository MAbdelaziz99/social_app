import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/post_model.dart';
import 'package:social_app/presentation/posts/cubit/posts_states.dart';
import 'package:social_app/presentation/posts/firebase/post_liking.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/posts_get_data.dart';
import 'package:social_app/shared/components/snackbar.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  Map<String, bool> likedMap = {};
  List<double> sliderHeights = [];
  List<int> sliderIndexes = [];
  List<List<double>> imageHeights = [];

  getPosts({required context}) async {
    emit(PostsGetLoadingState());
    PostsGetData postGetting = PostsGetData.getInstance();
    postGetting.getPosts(
        getPosts: (value) => posts = value,
        getLikedMap: (value) => likedMap = value,
        getSliderIndexes: (value) => sliderIndexes = value,
        getSliderHeights: (value) => sliderHeights = value,
        getImagesHeight: (value) => imageHeights = value,
        context: context,
        onSuccessListen: () => emit(PostsGetSuccessState()),
        onErrorListen: (error) => emit(PostsGetErrorState()));
  }

  likePost({required context, required PostModel postModel}) {
    PostLiking postLiking = PostLiking.getInstance();
    postLiking.likePost(
      postModel: postModel,
        onLikeSuccessListen: () => emit(PostLikeSuccessState()),
        onLikeErrorListen: (error) {
          defaultErrorSnackBar(
              message: 'Failed to like this post, try again', context: context);
          emit(PostLikeErrorState());
        });
  }

  changeSliderIndex({required int itemIndex, required int sliderIndex}) {
    sliderIndexes[itemIndex] = sliderIndex;
    emit(PostChangeSliderIndex());
  }
}
