import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/data/models/post_model.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/comments_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/images_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/likes_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/times_getting.dart';
import 'package:social_app/presentation/posts/firebase/posts_data/users_getting.dart';

class PostsGetting {
  static PostsGetting instance = PostsGetting();

  static PostsGetting getInstance() => instance;

  Future getPosts(
      {required context,
      required Function(List<PostModel> postModels) getPosts,
      required Function(Map<String, bool> likedMap) getLikedMap,
      required Function(List<double> sliderHeights) getSliderHeights,
      required Function(List<int> sliderIndexes) getSliderIndexes,
      required Function(List<List<double>> imagesHeight) getImagesHeight,
      required Function onSuccessListen,
      required Function onErrorListen}) async {
    FirebaseFirestore.instance
        .collection('Posts')
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
        await UsersGetting.getInstance().getPostsUsers(postModel: postModel);

        await LikesGetting.getInstance().getLikes(
            likedMap: likedMap,
            getLikedMap: (value) {
              likedMap = value;
              getLikedMap(likedMap);
            },
            postModel: postModel);

        await CommentsGetting.getInstance().getComments(onSuccessListen: onSuccessListen,postModel: postModel);

        await TimesGetting.getInstance().getTimes(postModel: postModel);

        ImagesGetting.getInstance().getImages(
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
    }).onError(onErrorListen);
  }
}
