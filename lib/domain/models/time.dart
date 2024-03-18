import 'package:equatable/equatable.dart';

class TimeModel extends Equatable {
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final int seconds;
  final int milliSeconds;
  final DateTime dateTime;
  final String date;
  final String time;
  final String timeZone;
  final String dayOfWeek;
  final bool dstActive;

  const TimeModel({
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

  @override
  List<Object?> get props => [
        year,
        month,
        day,
        hour,
        minute,
        seconds,
        milliSeconds,
        dateTime,
        date,
        time,
        timeZone,
        dayOfWeek,
        dstActive,
      ];
}
