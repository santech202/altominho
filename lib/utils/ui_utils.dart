import 'package:intl/intl.dart';

class DistanceUtil {
  static String toReadableDistance(double distance) {
    distance /= 1000;
    return distance.toStringAsFixed(2) + "km";
  }
}

class TimeUtil {
  static String toReadableTime(int time) {
    return DateFormat().add_Hm().format(DateTime.fromMillisecondsSinceEpoch(time));
  }
  static String dateString({DateTime dateTime}) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return dateTime == null? dateFormat.format(DateTime.now()): dateFormat.format(dateTime);
  }
  static String timeNowString() {
    return DateFormat('HH:mm').format(DateTime.now());
  }
}
