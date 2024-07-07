import 'dart:convert';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HTTP Response Extension', () {
    final tEmptyBody = jsonEncode({});

    test('returns void if statusCode is 200', () {
      final response = http.Response(tEmptyBody, 200);
      response.checkException();
      expect(() => response.checkException(), returnsNormally);
    });

    test('throws UnauthorizedException if statusCode is 401', () {
      final response = http.Response(tEmptyBody, 401);
      expect(() => response.checkException(),
          throwsA(isA<UnauthorizedException>()));
    });
    test('throws InsufficientBalanceException if statusCode is 402', () {
      final response = http.Response(tEmptyBody, 402);
      expect(() => response.checkException(),
          throwsA(isA<InsufficientBalanceException>()));
    });

    test('throws NotFoundException if statusCode is 404', () {
      final response = http.Response(tEmptyBody, 404);
      expect(
          () => response.checkException(), throwsA(isA<NotFoundException>()));
    });

    test('throws ServerException if statusCode is 500', () {
      final response = http.Response(tEmptyBody, 500);
      expect(() => response.checkException(), throwsA(isA<ServerException>()));
    });

    test(
        'throws BadResponseException if statusCode is not 200, 401, 404, or 500',
        () {
      final response = http.Response(tEmptyBody, 403);
      expect(() => response.checkException(),
          throwsA(isA<BadResponseException>()));
    });
  });
}
