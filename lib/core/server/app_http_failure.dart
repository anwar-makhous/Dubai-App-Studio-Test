import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class AppHttpFailure extends Equatable {
  final http.BaseRequest request;
  final int statusCode;
  final String errorMessage;

  const AppHttpFailure._(
      {required this.request,
      required this.statusCode,
      required this.errorMessage});

  static http.StreamedResponse response({
    required http.BaseRequest request,
    int statusCode = 500,
    String? errorMessage,
  }) {
    final json = jsonEncode({
      'success': false,
      if (errorMessage != null) 'error': errorMessage,
    });
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      statusCode,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      request: request,
    );
    return streamedResponse;
  }

  @override
  List<Object?> get props => [request, statusCode, errorMessage];
}
