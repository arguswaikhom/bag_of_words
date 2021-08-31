class FailedResException implements Exception {
  final String? message;

  @pragma("vm:entry-point")
  const FailedResException([this.message]);

  @override
  String toString() => message ?? 'Returned failed response.';
}
