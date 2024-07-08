// ignore_for_file: overridden_fields, use_super_parameters
part of 'error.dart';

abstract class Failure extends Equatable {
  final String? _message;
  const Failure([this._message]);

  String get errorMessage;

  @override
  List<Object> get props => [_message ?? ''];

  factory Failure.fromException(Exception e) {
    switch (e) {
      case NoInternetException exception:
        return NoInternetFailure(exception.message);
      case UnauthorizedException exception:
        return UnauthorizedFailure(exception.message);
      case NotFoundException exception:
        return NotFoundFailure(exception.message);
      case ServerException exception:
        return ServerFailure(exception.message);
      case UnknownException exception:
        return UnknownFailure(exception.message);
      case BadResponseException exception:
        return BadResponseFailure(exception.message);
      case InsufficientBalanceException exception:
        return InsufficientBalanceFailure(exception.message);
      case FormatException _:
        return const BadResponseFailure(FailureMessages.badResponse);
      default:
        return const UnknownFailure(FailureMessages.unknown);
    }
  }
}

class NoInternetFailure extends Failure {
  @override
  final String? _message;
  const NoInternetFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? FailureMessages.noInternet;
}

class UnauthorizedFailure extends Failure {
  @override
  final String? _message;
  const UnauthorizedFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? FailureMessages.error401;
}

class NotFoundFailure extends Failure {
  @override
  final String? _message;
  const NotFoundFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? FailureMessages.error404;
}

class ServerFailure extends Failure {
  @override
  final String? _message;
  const ServerFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? FailureMessages.error500;
}

class UnknownFailure extends Failure {
  @override
  final String? _message;
  const UnknownFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? FailureMessages.unknown;
}

class BadResponseFailure extends Failure {
  @override
  final String? _message;
  const BadResponseFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? FailureMessages.badResponse;
}

class InsufficientBalanceFailure extends Failure {
  @override
  final String? _message;
  const InsufficientBalanceFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? FailureMessages.error402;
}

class FailureMessages {
  FailureMessages._();
  static const String noInternet = 'Please check your connection!';
  static const String error401 = "Unauthorized!";
  static const String error402 = "Insufficient balance!";
  static const String error404 = "Not Found!";
  static const String error500 = "Server Error!";
  static const String unknown = "Something went wrong!";
  static const String badResponse = "Bad response format!";
}
