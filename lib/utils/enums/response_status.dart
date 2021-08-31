enum ResponseStatus { SUCCESS, EMPTY, FAILED }

extension ResponseStatusX on ResponseStatus {
  static ResponseStatus createFromAnyString(String string) {
    return ResponseStatus.values.firstWhere((e) {
      final action = '${(ResponseStatus).toString()}.${string.toUpperCase()}';
      return e.toString() == action;
    });
  }
}
