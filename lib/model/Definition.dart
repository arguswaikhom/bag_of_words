import 'dart:convert';

import 'package:bag_of_words/model/Phonetic.dart';
import 'package:bag_of_words/model/Sense.dart';

class Definition {
  String word;
  String origin;
  List<Phonetic> phonetics;
  List<Sense> senses;

  Definition({
    this.word,
    this.origin,
    this.phonetics,
    this.senses,
  });

  factory Definition.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Definition(
      word: map['word'],
      origin: map['origin'],
      phonetics: List<Phonetic>.from(
          map['phonetics']?.map((x) => Phonetic.fromMap(x))),
      senses: List<Sense>.from(map['senses']?.map((x) => Sense.fromMap(x))),
    );
  }

  factory Definition.fromJson(String source) =>
      Definition.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'origin': origin,
      'phonetics': phonetics?.map((x) => x?.toMap())?.toList(),
      'senses': senses?.map((x) => x?.toMap())?.toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
