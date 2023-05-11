import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/post_model.dart';
import 'package:social_app/presentation/profile/cubit/profile_states.dart';
import 'package:social_app/presentation/profile/firebase/get_profile_posts.dart';

import '../../../shared/components/snackbar.dart';
import '../../../shared/constatnts.dart';
import '../../posts/firebase/like_post.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  String postsStatus = '';
  List<PostModel> posts = [];
  Map<String, bool> likedMap = {};
  List<double> sliderHeights = [];
  List<int> sliderIndexes = [];
  List<List<double>> imageHeights = [];

  getPosts({required context}) async {
    postsStatus = FirebaseStatus.loading.name;
    emit(ProfileGetPostsLoadingState());
    GetProfilePosts getProfilePosts = GetProfilePosts.getInstance();
    getProfilePosts.getPosts(
      getPosts: (value) => posts = value,
      getLikedMap: (value) => likedMap = value,
      getSliderIndexes: (value) => sliderIndexes = value,
      getSliderHeights: (value) => sliderHeights = value,
      getImagesHeight: (value) => imageHeights = value,
      context: context,
      onSuccessListen: () => emit(ProfileGetPostsSuccessState()),
      onAllPostsDataSuccess: () {
        postsStatus = FirebaseStatus.success.name;
        if (!isClosed) {
          emit(ProfileGetPostsSuccessState());
        }
      },
      onErrorListen: (error) => emit(ProfileGetPostsErrorState()),
    );
  }

  likePost({required context, required PostModel postModel}) {
    LikePost postLiking = LikePost.getInstance();
    postLiking.likePost(
        postModel: postModel,
        onLikeSuccessListen: () => emit(ProfileLikeSuccessState()),
        onLikeErrorListen: (error) {
          defaultErrorSnackBar(
              message: 'Failed to like this post, try again',
              title: 'Like a post');
          emit(ProfileLikeErrorState());
        });
  }

  changeSliderIndex({required int itemIndex, required int sliderIndex}) {
    sliderIndexes[itemIndex] = sliderIndex;
    emit(ProfileChangeSliderIndexState());
  }
}
