import 'package:intl/intl.dart';

String capitalize(String s) =>
    s.length >= 1 ? s[0].toUpperCase() + s.substring(1) : s;

final dateFormat = new DateFormat('MMMM yyyy');

String renderDate(DateTime fromDate, DateTime toDate) {
  String from = fromDate != null ? dateFormat.format(fromDate) : '';
  String to = toDate != null ? dateFormat.format(toDate) : '';
  return "$from - $to";
}
