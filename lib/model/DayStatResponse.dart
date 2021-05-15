import 'dart:convert';

import 'DayStat.dart';

class DayStatResponse {
  String status;
  DayStat stat;

  DayStatResponse(this.status, this.stat);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'stat': stat.toMap(),
    };
  }

  factory DayStatResponse.fromMap(Map<String, dynamic> map) {
    return DayStatResponse(
      map['status'],
      DayStat.fromMap(map['stat']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DayStatResponse.fromJson(String source) =>
      DayStatResponse.fromMap(json.decode(source));
}
