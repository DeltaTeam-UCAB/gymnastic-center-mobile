class HttpResponse {
  final int statusCode;
  final Map<String, dynamic>? body;
  HttpResponse({required this.statusCode, this.body});
}

class HttpResponseParsed<T> extends HttpResponse {
  final T bodyParsed;
  HttpResponseParsed(
      {required super.body,
      required super.statusCode,
      required this.bodyParsed});
}

abstract class HttpHandler {
  Future<HttpResponse> get(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries});
  Future<HttpResponseParsed<T>> getParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic>) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries});
  Future<HttpResponse> post(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body});
  Future<HttpResponseParsed<T>> postParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic>) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body});
  Future<HttpResponse> put(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body});
  Future<HttpResponseParsed<T>> putParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic>) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body});
  Future<HttpResponse> delete(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries});
  Future<HttpResponseParsed<T>> deleteParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic>) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries});
}
