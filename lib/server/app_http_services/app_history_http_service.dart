part of 'app_http_services.dart';

class AppHistoryHttpService {
  final AppStorage storage;

  AppHistoryHttpService({required this.storage});

  Future<http.StreamedResponse> fetchHistory(http.BaseRequest request) async {
    final String? data = await storage.read(key: 'history');
    final json = data ?? "[]";
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }
}
