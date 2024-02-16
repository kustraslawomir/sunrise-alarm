import 'package:intl/intl.dart';

abstract class DateTimeFormatter {
  static String toHHmm(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
