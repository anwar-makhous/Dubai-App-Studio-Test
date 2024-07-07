part of 'error.dart';

extension ResponseExtension on http.Response {
  /// returns void if [statusCode] == 200 or throws an [Exception] depending on [statusCode]
  void checkException() {
    switch (statusCode) {
      case 200:
        return;
      case 401:
        String? errorMessage = jsonDecode(body)["error"];
        throw UnauthorizedException(errorMessage);
      case 402:
        String? errorMessage = jsonDecode(body)["error"];
        throw InsufficientBalanceException(errorMessage);
      case 404:
        String? errorMessage = jsonDecode(body)["error"];
        throw NotFoundException(errorMessage);
      case 500:
        String? errorMessage = jsonDecode(body)["error"];
        throw ServerException(errorMessage);
      default:
        String? errorMessage = jsonDecode(body)["error"];
        throw BadResponseException(errorMessage);
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

class InsufficientBalanceException implements Exception {
  final String? message;
  InsufficientBalanceException([this.message]);
}
