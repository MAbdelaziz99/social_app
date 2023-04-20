import 'package:flutter/cupertino.dart';
import 'package:social_app/data/models/post_model.dart';

class GetImages {
  static GetImages instance = GetImages();

  static GetImages getInstance() => instance;

  getImages(
      PostModel postModel,
      context,
      List<double> sliderHeights,
      List<List<double>> allImageHeights,
      Function(List<double> sliderHeights) getSliderHeights,
      Function(List<List<double>> imagesHeight) getImagesHeight,
      ) {
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
    getSliderHeights(sliderHeights);
    getImagesHeight(allImageHeights);
  }
}
