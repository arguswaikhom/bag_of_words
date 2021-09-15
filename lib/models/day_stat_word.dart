import 'dart:convert';

import 'package:bag_of_words/models/action_word.dart';
import 'package:bag_of_words/models/definition.dart';

class DayStatWord {
  ActionWord word;
  Definition? def;
  bool isDefVisible;
  bool isDefFetching;

  DayStatWord({
    required this.word,
    this.def,
    this.isDefVisible = false,
    this.isDefFetching = false,
  });

  factory DayStatWord.fromMap(Map<String, dynamic> map) =>
      DayStatWordX.fromMap(map);

  factory DayStatWord.fromJson(String source) => DayStatWordX.fromJson(source);
}

extension DayStatWordX on DayStatWord {
  Map<String, dynamic> toMap() {
    return {
      'word': word.toMap(),
      'def': def?.toMap(),
      'isDefVisible': isDefVisible,
      'isDefFetching': isDefFetching,
    };
  }

  static DayStatWord fromMap(Map<String, dynamic> map) {
    return DayStatWord(
      word: ActionWord.fromMap(map),
      def: map['def'] == null ? null : Definition.fromMap(map['def']),
      isDefVisible: map['isDefVisible'] ?? false,
      isDefFetching: map['isDefFetching'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  static DayStatWord fromJson(String source) => fromMap(json.decode(source));
}
