import 'dart:convert';

import 'package:bag_of_words/models/day_stat_word.dart';

class DayStat {
  int day;
  int total;
  int learn;
  int recall;
  String uid;
  String dayStatId;
  List<DayStatWord> words;

  DayStat({
    required this.day,
    required this.total,
    required this.learn,
    required this.recall,
    required this.uid,
    required this.dayStatId,
    this.words = const [],
  });

  factory DayStat.fromMap(Map<String, dynamic> map) => DayStatX.fromMap(map);
  factory DayStat.fromJson(String source) => DayStatX.fromJson(source);
}

extension DayStatX on DayStat {
  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'total': total,
      'learn': learn,
      'recall': recall,
      'uid': uid,
      'dayStatId': dayStatId,
      'words': words.map((x) => x.toMap()).toList(),
    };
  }

  static DayStat fromMap(Map<String, dynamic> map) {
    final words = map['words'];
    return DayStat(
      day: map['day'],
      total: map['total'],
      learn: map['learn'],
      recall: map['recall'],
      uid: map['uid'],
      dayStatId: map['dayStatId'],
      words: words == null
          ? []
          : List<DayStatWord>.from(words.map((x) => fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static DayStat fromJson(String source) => fromMap(json.decode(source));
}
