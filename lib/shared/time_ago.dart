
class TimeAgo
{
  static const int secondMillis = 1000;
  static const int minuteMillis = 60 * secondMillis;
  static const int hourMillis = 60 * minuteMillis;
  static const int dayMillis = 24 * hourMillis;
  static const int monthMillis = 30 *  dayMillis;
  static const int yearMillis = 12 * monthMillis;

  static String? getTimeAgo(int time)
  {
    if (time < 1000000000000)
    {
      // if timestamp given in seconds, convert to millis
      time *= 1000;
    }

    int now = DateTime.now().millisecondsSinceEpoch;
    if (time > now || time <= 0)
    {
      return null;
    }

    final int diff = now - time;
    if (diff < minuteMillis)
    {
      return "now";
    }
    else if (diff < 2 * minuteMillis)
    {
      return "1 minute ago";
    }
    else if (diff < 50 * minuteMillis)
    {
      return "${diff ~/ minuteMillis} minute ago";
    }
    else if (diff < 90 * minuteMillis)
    {
      return "1 hour ago";
    }
    else if (diff < 24 * hourMillis)
    {
      return  "${diff ~/ hourMillis.toInt()}  hour ago";
    }
    else if (diff < 30 * dayMillis)
    {

      return "${diff ~/ dayMillis.toInt()} day ago";
    }
    else if(diff < 12*monthMillis) {
      return "${diff ~/ monthMillis.toInt()} month ago";
    } else
    {
      return "${diff~/yearMillis.toInt()} year ago";
    }
  }

}