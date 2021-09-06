import 'dart:convert';

import 'package:bag_of_words/models/phonetic.dart';
import 'package:bag_of_words/models/sense.dart';

class Definition {
  String word;
  String? origin;
  List<Phonetic> phonetics;
  List<Sense> senses;

  Definition({
    required this.word,
    this.origin,
    this.phonetics = const [],
    this.senses = const [],
  });

  factory Definition.fromMap(Map<String, dynamic> map) =>
      DefinitionX.fromMap(map);

  factory Definition.fromJson(String source) => DefinitionX.fromJson(source);
}

extension DefinitionX on Definition {
  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'origin': origin,
      'phonetics': phonetics.map((x) => x.toMap()).toList(),
      'senses': senses.map((x) => x.toMap()).toList(),
    };
  }

  static Definition fromMap(Map<String, dynamic> map) {
    final phonetics = map['phonetics'];
    final senses = map['senses'];
    return Definition(
      word: map['word'],
      origin: map['origin'],
      phonetics: phonetics == null
          ? []
          : List<Phonetic>.from(phonetics.map((x) => Phonetic.fromMap(x))),
      senses: senses == null
          ? []
          : List<Sense>.from(senses.map((x) => Sense.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Definition fromJson(String source) => fromMap(json.decode(source));
}
