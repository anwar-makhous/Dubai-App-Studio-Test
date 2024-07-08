import 'package:dubai_app_studio/core/error/error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure.fromException', () {
    test('should return NoInternetFailure when NoInternetException is passed',
        () {
      final exception = NoInternetException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<NoInternetFailure>());
      expect(failure.errorMessage, FailureMessages.noInternet);
    });

    test(
        'should return UnauthorizedFailure when UnauthorizedException is passed',
        () {
      final exception = UnauthorizedException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<UnauthorizedFailure>());
      expect(failure.errorMessage, FailureMessages.error401);
    });

    test('should return NotFoundFailure when NotFoundException is passed', () {
      final exception = NotFoundException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<NotFoundFailure>());
      expect(failure.errorMessage, FailureMessages.error404);
    });

    test('should return ServerFailure when ServerException is passed', () {
      final exception = ServerException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<ServerFailure>());
      expect(failure.errorMessage, FailureMessages.error500);
    });

    test('should return UnknownFailure when UnknownException is passed', () {
      final exception = UnknownException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<UnknownFailure>());
      expect(failure.errorMessage, FailureMessages.unknown);
    });

    test('should return BadResponseFailure when BadResponseException is passed',
        () {
      final exception = BadResponseException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<BadResponseFailure>());
      expect(failure.errorMessage, FailureMessages.badResponse);
    });
    test(
        'should return InsufficientBalanceFailure when InsufficientBalanceException is passed',
        () {
      final exception = InsufficientBalanceException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<InsufficientBalanceFailure>());
      expect(failure.errorMessage, FailureMessages.error402);
    });
    test('should return BadResponseFailure when FormatException is passed', () {
      const exception = FormatException();
      final failure = Failure.fromException(exception);
      expect(failure, isA<BadResponseFailure>());
      expect(failure.errorMessage, FailureMessages.badResponse);
    });

    test('should return UnknownFailure when unknown exception is passed', () {
      final exception = Exception();
      final failure = Failure.fromException(exception);
      expect(failure, isA<UnknownFailure>());
      expect(failure.errorMessage, FailureMessages.unknown);
    });
  });
}
