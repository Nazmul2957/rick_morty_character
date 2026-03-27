// lib/core/errors/exceptions.dart

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({required this.message});
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({required this.message});
}