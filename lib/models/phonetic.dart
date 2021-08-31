import 'dart:convert';

class Phonetic {
  String phonetic;
  String audio;

  Phonetic({
    required this.phonetic,
    required this.audio,
  });

  factory Phonetic.fromMap(Map<String, dynamic> map) => PhoneticX.fromMap(map);

  factory Phonetic.fromJson(String source) => PhoneticX.fromJson(source);
}

extension PhoneticX on Phonetic {
  Map<String, dynamic> toMap() {
    return {
      'phonetic': phonetic,
      'audio': audio,
    };
  }

  static Phonetic fromMap(Map<String, dynamic> map) {
    return Phonetic(
      phonetic: map['phonetic'],
      audio: map['audio'],
    );
  }

  String toJson() => json.encode(toMap());

  static Phonetic fromJson(String source) => fromMap(json.decode(source));
}
