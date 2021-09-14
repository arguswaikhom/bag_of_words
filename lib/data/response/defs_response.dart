import 'dart:convert';

import 'package:bag_of_words/models/definition.dart';
import 'package:bag_of_words/utils/enums/response_status.dart';

class DefsResponse {
  ResponseStatus status;
  String? nextUrl;
  List<Definition> defs;

  DefsResponse({
    required this.status,
    this.nextUrl,
    this.defs = const [],
  });

  factory DefsResponse.fromMap(Map<String, dynamic> map) =>
      DefsResponseX.fromMap(map);

  factory DefsResponse.fromJson(String source) =>
      DefsResponseX.fromJson(source);
}

extension DefsResponseX on DefsResponse {
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'nextUrl': nextUrl,
      'defs': defs.map((x) => x.toMap()).toList(),
    };
  }

  static DefsResponse fromMap(Map<String, dynamic> map) {
    final defs = map['defs'];
    return DefsResponse(
      status: ResponseStatusX.createFromAnyString(map['status']),
      nextUrl: map['nextUrl'],
      defs: defs == null
          ? []
          : List<Definition>.from(defs.map((x) => Definition.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static DefsResponse fromJson(String source) => fromMap(json.decode(source));
}
