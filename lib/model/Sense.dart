import 'dart:convert';

class Sense {
  String? definition;
  List<String>? examples;

  Sense({
    this.definition,
    this.examples,
  });

  static Sense? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return Sense(
      definition: map['definition'],
      examples: List<String>.from(map['examples']),
    );
  }

  static Sense? fromJson(String source) => Sense.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'definition': definition,
      'examples': examples,
    };
  }

  String toJson() => json.encode(toMap());
}
