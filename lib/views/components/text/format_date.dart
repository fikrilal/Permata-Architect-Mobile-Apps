import 'package:intl/intl.dart';

String dateMonth({String? date}) {
  DateTime _dateTime = new DateFormat('yyyy-MM-dd').parse(date!);
  String formatDate = DateFormat('dd MMMM').format(_dateTime);
  return formatDate;
}
