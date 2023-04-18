import 'package:intl/intl.dart';

import '../../../../data/models/post_model.dart';
import '../../../../shared/time_ago.dart';

class TimesGetting{

  static TimesGetting instance = TimesGetting();
  static TimesGetting getInstance() => instance;

  getTimes(
      {required Function onSuccessListen,
        required PostModel postModel}) {
    DateTime sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(postModel.postTime ?? '');

    int millisecond = sdf.millisecondsSinceEpoch;
    String? time = TimeAgo.getTimeAgo(millisecond);
    postModel.postTime = time;
    onSuccessListen();
  }
}