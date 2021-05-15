import 'dart:convert';

import 'package:bag_of_words/model/Definition.dart';

class DefinitionsResponse {
  String status;
  String nextUrl;
  List<Definition> defs;
  DefinitionsResponse({
    this.status,
    this.nextUrl,
    this.defs,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'nextUrl': nextUrl,
      'defs': defs?.map((x) => x.toMap())?.toList(),
    };
  }

  factory DefinitionsResponse.fromMap(Map<String, dynamic> map) {
    return DefinitionsResponse(
      status: map['status'],
      nextUrl: map['nextUrl'],
      defs:
          List<Definition>.from(map['defs']?.map((x) => Definition.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DefinitionsResponse.fromJson(String source) =>
      DefinitionsResponse.fromMap(json.decode(source));
}
