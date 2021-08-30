import 'dart:convert';

import 'package:bag_of_words/model/Definition.dart';

class DayStatWord {
  String? word;
  String? action;
  Definition? def;
  bool isVisible;
  bool isProgressing;

  DayStatWord({
    this.word,
    this.action,
    this.def,
    this.isVisible = false,
    this.isProgressing = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'action': action,
      'def': def?.toMap(),
      'isVisible': isVisible,
      'isProgressing': isProgressing,
    };
  }

  factory DayStatWord.fromMap(Map<String, dynamic> map) {
    return DayStatWord(
      word: map['word'],
      action: map['action'],
      def: Definition.fromMap(map['def']),
      isVisible: map['isVisible'] ?? false,
      isProgressing: map['isProgressing'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DayStatWord.fromJson(String source) =>
      DayStatWord.fromMap(json.decode(source));
}
