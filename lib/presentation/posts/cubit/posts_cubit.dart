import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/post_model.dart';
import 'package:social_app/presentation/posts/cubit/posts_states.dart';
import 'package:social_app/presentation/posts/firebase/post_liking.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/get_posts.dart';
import 'package:social_app/shared/components/snackbar.dart';
import 'package:social_app/shared/constatnts.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  Map<String, bool> likedMap = {};
  List<double> sliderHeights = [];
  List<int> sliderIndexes = [];
  List<List<double>> imageHeights = [];

  String postsStatus = '';

  getPosts({required context}) async {
    postsStatus = FirebaseStatus.loading.name;
    emit(PostsGetLoadingState());
    GetPosts postGetting = GetPosts.getInstance();
    postGetting.getPosts(
        getPosts: (value) => posts = value,
        getLikedMap: (value) => likedMap = value,
        getSliderIndexes: (value) => sliderIndexes = value,
        getSliderHeights: (value) => sliderHeights = value,
        getImagesHeight: (value) => imageHeights = value,
        context: context,
        onSuccessListen: () => emit(PostsGetSuccessState()),
        onAllPostsDataSuccess: () {
          postsStatus = FirebaseStatus.success.name;
          emit(PostsGetSuccessState());
        },
        onErrorListen: (error) {
          postsStatus = FirebaseStatus.error.name;
          emit(PostsGetSuccessState());
        });
  }

  likePost({required context, required PostModel postModel}) {
    PostLiking postLiking = PostLiking.getInstance();
    postLiking.likePost(
        postModel: postModel,
        onLikeSuccessListen: () => emit(PostLikeSuccessState()),
        onLikeErrorListen: (error) {
          defaultErrorSnackBar(
              message: 'Failed to like this post, try again', title: 'Like a post');
          emit(PostLikeErrorState());
        });
  }

  changeSliderIndex({required int itemIndex, required int sliderIndex}) {
    sliderIndexes[itemIndex] = sliderIndex;
    emit(PostChangeSliderIndex());
  }
}
