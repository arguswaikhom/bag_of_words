import 'dart:convert';

import 'DayStatWord.dart';

class DayStat {
  int day;
  int total;
  int learn;
  int recall;
  String uid;
  String dayStatId;
  List<DayStatWord> words;

  DayStat({
    this.day,
    this.total,
    this.learn,
    this.recall,
    this.uid,
    this.dayStatId,
    this.words,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'total': total,
      'learn': learn,
      'recall': recall,
      'uid': uid,
      'dayStatId': dayStatId,
      'words': words?.map((x) => x.toMap())?.toList(),
    };
  }

  factory DayStat.fromMap(Map<String, dynamic> map) {
    return DayStat(
      day: map['day'],
      total: map['total'],
      learn: map['learn'],
      recall: map['recall'],
      uid: map['uid'],
      dayStatId: map['dayStatId'],
      words: List<DayStatWord>.from(
        map['words']?.map((x) => DayStatWord.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DayStat.fromJson(String source) =>
      DayStat.fromMap(json.decode(source));
}
