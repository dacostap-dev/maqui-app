class TimeModel {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int seconds;
  int milliSeconds;
  DateTime dateTime;
  String date;
  String time;
  String timeZone;
  String dayOfWeek;
  bool dstActive;

  TimeModel({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.seconds,
    required this.milliSeconds,
    required this.dateTime,
    required this.date,
    required this.time,
    required this.timeZone,
    required this.dayOfWeek,
    required this.dstActive,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) => TimeModel(
        year: json["year"],
        month: json["month"],
        day: json["day"],
        hour: json["hour"],
        minute: json["minute"],
        seconds: json["seconds"],
        milliSeconds: json["milliSeconds"],
        dateTime: DateTime.parse(json["dateTime"]),
        date: json["date"],
        time: json["time"],
        timeZone: json["timeZone"],
        dayOfWeek: json["dayOfWeek"],
        dstActive: json["dstActive"],
      );
}
