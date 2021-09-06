import 'dart:convert';

class Sense {
  String definition;
  List<String> examples;

  Sense({
    required this.definition,
    this.examples = const [],
  });

  factory Sense.fromMap(Map<String, dynamic> map) => SenseX.fromMap(map);

  factory Sense.fromJson(String source) => SenseX.fromJson(source);
}

extension SenseX on Sense {
  Map<String, dynamic> toMap() {
    return {
      'definition': definition,
      'examples': examples,
    };
  }

  static Sense fromMap(Map<String, dynamic> map) {
    final examples = map["examples"];
    return Sense(
      definition: map['definition'],
      examples: examples == null ? [] : List<String>.from(examples),
    );
  }

  String toJson() => json.encode(toMap());

  static Sense fromJson(String source) => fromMap(json.decode(source));
}
