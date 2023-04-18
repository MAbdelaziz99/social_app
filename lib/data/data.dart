import 'package:social_app/data/models/post_model.dart';

import 'models/user_model.dart';

UserModel? userModel;

List<PostModel> allPosts = [];

Map<String, bool> likedMap = {};

List<double> sliderHeights = [];

List<List<double>> allImageHeights = [];

List<int> sliderIndexes = [];