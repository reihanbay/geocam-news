import 'package:intl/intl.dart';

String formattedDate(String src, {String format = 'dd MMM yyyy'}) {
  DateTime dateTime = DateTime.parse(src);

  String formattedDate = DateFormat(format).format(dateTime.toLocal());

  return formattedDate;
}