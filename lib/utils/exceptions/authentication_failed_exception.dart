class AuthenticationFailedException implements Exception {
  final String? message;

  @pragma("vm:entry-point")
  const AuthenticationFailedException([this.message]);

  @override
  String toString() => message ?? 'Failed to authenticate user.';
}
