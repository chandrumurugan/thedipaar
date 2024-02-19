



import 'package:intl/intl.dart';

class DateDayConverter {
  static String getTimeDifference(DateTime providedDateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(providedDateTime);

    int differenceInDays = difference.inDays;
  

    if (differenceInDays == 0) {
      return 'Today';
    } else if (differenceInDays == 1) {
      return '1 day ago';
    } else if (differenceInDays < 7) {
      return '$differenceInDays days ago';
    } else {
      // If the difference is more than a week, handle it as needed
      DateFormat formatter = DateFormat('dd-MM-yyyy'); //dd-MM-yyyy
      return formatter.format(providedDateTime);
    }
  }
}