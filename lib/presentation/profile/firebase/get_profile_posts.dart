import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/app_data/user_data.dart';

import '../../../data/models/post_model.dart';
import '../../posts/firebase/posts_data/get_post_comments.dart';
import '../../posts/firebase/posts_data/get_post_images.dart';
import '../../posts/firebase/posts_data/get_post_likes.dart';
import '../../posts/firebase/posts_data/get_post_times.dart';

class GetProfilePosts {
  static GetProfilePosts getInstance() => GetProfilePosts();

  getPosts(
      {required context,
        required Function(List<PostModel> postModels) getPosts,
      required Function(Map<String, bool> likedMap) getLikedMap,
      required Function(List<double> sliderHeights) getSliderHeights,
      required Function(List<int> sliderIndexes) getSliderIndexes,
      required Function(List<List<double>> imagesHeight) getImagesHeight,
      required Function onAllPostsDataSuccess,
      required Function onSuccessListen,
      required Function onErrorListen}) {
    FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: userModel?.uid)
        .snapshots()
        .listen((event) async {
      List<PostModel> allPosts = [];
      Map<String, bool> likedMap = {};
      List<double> sliderHeights = [];
      List<int> sliderIndexes = [];
      List<List<double>> allImageHeights = [];
      for (var element in event.docs) {
        sliderIndexes.add(0);

        PostModel postModel = PostModel.fromJson(element.data());

        await GetPostLikes.getInstance().getLikes(
            likedMap: likedMap,
            getLikedMap: (value) {
              likedMap = value;
              getLikedMap(likedMap);
            },
            postModel: postModel);

        await GetPostComments.getInstance().getComments(
            onSuccessListen: onSuccessListen, postModel: postModel);

        await GetPostTimes.getInstance().getTimes(postModel: postModel);

        GetImages.getInstance().getImages(
          postModel,
          context,
          sliderHeights,
          allImageHeights,
          getSliderHeights,
          getImagesHeight,
        );

        allPosts.add(postModel);
      }
      getSliderIndexes(sliderIndexes);
      getPosts(allPosts);
      onSuccessListen();
      onAllPostsDataSuccess();
    }).onError(onErrorListen);
  }
}
