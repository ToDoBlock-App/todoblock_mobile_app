extension TimestampExtension on int? {
  // Convert an int (Unix timestamp) to a DateTime in UTC
  DateTime get toDateTimeUtc => DateTime.fromMillisecondsSinceEpoch(this != null ? this! * 1000 : DateTime.now().millisecondsSinceEpoch, isUtc: true);

  // Convert a DateTime to an int (Unix timestamp) considering the time zone
  static int fromDateTime(DateTime dateTime) {
    // If the DateTime is not in UTC, first convert it to UTC
    DateTime inUtc = dateTime.isUtc ? dateTime : dateTime.toUtc();
    return inUtc.millisecondsSinceEpoch ~/ 1000;
  }
}
