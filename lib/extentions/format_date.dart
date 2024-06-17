import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  String formatDate() {
    DateFormat format = DateFormat('HH:mm [dd-MM-yyyy]');
    var formatted = format.format(this);
    return formatted;
  }
}
