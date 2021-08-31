extension IntX on int {
  /// Convert int to string
  /// If the int is a single digit number, add a prefix '0'
  String dualToString() => toString().length == 1 ? '0$toString()' : toString();
}
