part of 'error.dart';

extension ResponseExtension on http.Response {
  /// returns void if [statusCode] == 200 or throws an [Exception] depending on [statusCode]
  void checkException() {
    switch (statusCode) {
      case 200:
        return;
      case 401:
        throw UnauthorizedException();
      case 404:
        throw NotFoundException();
      case 500:
        throw ServerException();
      default:
        throw BadResponseException();
    }
  }
}

class NoInternetException implements Exception {
  final String? message;
  NoInternetException([this.message]);
}

class UnauthorizedException implements Exception {
  final String? message;
  UnauthorizedException([this.message]);
}

class NotFoundException implements Exception {
  final String? message;
  NotFoundException([this.message]);
}

class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);
}

class UnknownException implements Exception {
  final String? message;
  UnknownException([this.message]);
}

class BadResponseException implements Exception {
  final String? message;
  BadResponseException([this.message]);
}
