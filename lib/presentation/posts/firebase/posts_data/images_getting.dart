import 'package:flutter/cupertino.dart';
import 'package:social_app/data/models/post_model.dart';

import '../../../../data/data.dart';

class ImagesGetting {
  static ImagesGetting instance = ImagesGetting();

  static ImagesGetting getInstance() => instance;

  getImages({required context, required PostModel postModel, required Function onSuccessListen}){
    if (postModel.images.isNotEmpty) {
      double sliderHeight = 0.0;
      List<double> imageHeights = [];
      for (var image in postModel.images) {
        double finalHeight = (int.parse(image['imageHeight']) *
            MediaQuery.of(context).size.height.toInt()) /
            int.parse(image['imageWidth']).toInt();

        imageHeights.add(finalHeight);
        if (finalHeight > sliderHeight) {
          sliderHeight = finalHeight;
        }
      }
      sliderHeights.add(sliderHeight);

      allImageHeights.add(imageHeights);
    } else {
      allImageHeights.add([0.0]);
      sliderHeights.add(0.0);
    }
    onSuccessListen();
  }
}
