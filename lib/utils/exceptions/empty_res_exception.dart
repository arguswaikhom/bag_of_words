/// Use this exception when there is an empty response from the data source
/// Data source could be any data source; Local DB or Cloud or ...
class EmptyResException implements Exception {
  final String? message;

  @pragma("vm:entry-point")
  const EmptyResException([this.message]);

  @override
  String toString() => message ?? 'Returned response is empty.';
}
