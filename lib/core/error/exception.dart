class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});
}

class SshException implements Exception {
  final String message;
  const SshException({required this.message});
}
