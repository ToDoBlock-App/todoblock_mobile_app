import 'package:intl/intl.dart';

String formatTime(DateTime? dateTime) {
  return DateFormat('HH:mm:ss').format(dateTime!); // or 'hh:mm a' for 12-hour format
}