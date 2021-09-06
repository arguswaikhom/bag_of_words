import 'dart:convert';

class Phonetic {
  String? phonetic;
  String? audio;

  Phonetic({
    this.phonetic,
    this.audio,
  });

  static Phonetic? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return Phonetic(
      phonetic: map['phonetic'],
      audio: map['audio'],
    );
  }

  static Phonetic? fromJson(String source) =>
      Phonetic.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'phonetic': phonetic,
      'audio': audio,
    };
  }

  String toJson() => json.encode(toMap());
}
