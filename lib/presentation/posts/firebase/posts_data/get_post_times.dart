import 'package:intl/intl.dart';

import '../../../../data/models/post_model.dart';
import '../../../../shared/time_ago.dart';

class GetPostTimes {
  static GetPostTimes instance = GetPostTimes();

  static GetPostTimes getInstance() => instance;

  getTimes({required PostModel postModel}) {
    DateTime sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(postModel.postTime ?? '');

    int millisecond = sdf.millisecondsSinceEpoch;
    String? time = TimeAgo.getTimeAgo(millisecond);
    postModel.postTime = time;
  }
}
