import 'dart:convert';

import 'package:bag_of_words/utils/enums/action_word_action.dart';

class ActionWord {
  String word;
  ActionWordAction action;

  ActionWord({
    required this.word,
    required this.action,
  });

  factory ActionWord.fromMap(Map<String, dynamic> map) =>
      ActionWordX.fromMap(map);

  factory ActionWord.fromJson(String source) => ActionWordX.fromJson(source);
}

extension ActionWordX on ActionWord {
  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'action': action,
    };
  }

  static ActionWord fromMap(Map<String, dynamic> map) {
    return ActionWord(
      word: map['word'],
      action: ActionWordActionX.createFromAnyString(map['action']),
    );
  }

  String toJson() => json.encode(toMap());

  static ActionWord fromJson(String source) => fromMap(json.decode(source));
}
