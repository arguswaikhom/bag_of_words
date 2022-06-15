import 'dart:convert';

import 'package:bag_of_words/models/day_stat.dart';
import 'package:bag_of_words/utils/extensions/response_status.dart';

class DayStatResponse {
  ResponseStatus status;
  DayStat? stat;

  DayStatResponse(this.status, this.stat);

  factory DayStatResponse.fromMap(Map<String, dynamic> map) =>
      DayStatResponseX.fromMap(map);

  factory DayStatResponse.fromJson(String source) =>
      DayStatResponseX.fromJson(source);
}

extension DayStatResponseX on DayStatResponse {
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'stat': stat?.toMap(),
    };
  }

  static DayStatResponse fromMap(Map<String, dynamic> map) {
    return DayStatResponse(
      ResponseStatusX.createFromAnyString(map['status']),
      map['stat'] == null ? null : DayStat.fromMap(map['stat']),
    );
  }

  String toJson() => json.encode(toMap());

  static DayStatResponse fromJson(String source) =>
      fromMap(json.decode(source));
}
