sealed class AuthException implements Exception{
  final String message;

  AuthException({
    required this.message
  });
}

class AuthError extends AuthException {
  AuthError({required super.message});
}

class AuthUnauthorizedError extends AuthException {
  AuthUnauthorizedError({required super.message});
}
