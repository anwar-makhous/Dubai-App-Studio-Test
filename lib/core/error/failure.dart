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
      default:
        return const UnknownFailure(AppMessages.unknown);
    }
  }
}

class NoInternetFailure extends Failure {
  @override
  final String? _message;
  const NoInternetFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? AppMessages.noInternet;
}

class UnauthorizedFailure extends Failure {
  @override
  final String? _message;
  const UnauthorizedFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? AppMessages.error401;
}

class NotFoundFailure extends Failure {
  @override
  final String? _message;
  const NotFoundFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? AppMessages.error404;
}

class ServerFailure extends Failure {
  @override
  final String? _message;
  const ServerFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? AppMessages.error500;
}

class UnknownFailure extends Failure {
  @override
  final String? _message;
  const UnknownFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? AppMessages.unknown;
}

class BadResponseFailure extends Failure {
  @override
  final String? _message;
  const BadResponseFailure([this._message]) : super(_message);

  @override
  String get errorMessage => _message ?? AppMessages.badResponse;
}
