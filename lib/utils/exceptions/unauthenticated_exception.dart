class UnauthenticatedException implements Exception {
  final String? message;

  @pragma("vm:entry-point")
  const UnauthenticatedException([this.message]);

  @override
  String toString() => message ?? 'Authenticated user not found.';
}
