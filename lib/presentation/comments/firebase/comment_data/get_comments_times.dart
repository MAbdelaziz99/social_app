import 'package:intl/intl.dart';
import 'package:social_app/data/models/comment_model.dart';

import '../../../../shared/time_ago.dart';

class GetCommentsTimes {
  static final GetCommentsTimes _instance = GetCommentsTimes();

  static GetCommentsTimes getInstance() => _instance;

  getTimes({required CommentModel commentModel}) {
    DateTime sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(commentModel.commentTime ?? '');

    int millisecond = sdf.millisecondsSinceEpoch;
    String? time = TimeAgo.getTimeAgo(millisecond);
    commentModel.commentTime = time;
  }
}
