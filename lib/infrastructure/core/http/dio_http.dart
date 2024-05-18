import 'package:dio/dio.dart';
import 'package:gymnastic_center/infrastructure/core/http/http_service.dart';

class DioHttpHandler extends HttpHandler {
  final Dio dio;
  DioHttpHandler(String? url)
      : dio = url != null ? Dio(BaseOptions(baseUrl: url)) : Dio();

  @override
  Future<HttpResponse> get(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries}) async {
    final response = await dio.get(url,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries);
    return HttpResponse(
        body: response.data, statusCode: response.statusCode ?? 600);
  }

  @override
  Future<HttpResponseParsed<T>> getParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic> p1) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries}) async {
    final response = await dio.get(url,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries);
    return HttpResponseParsed(
        body: response.data,
        statusCode: response.statusCode ?? 600,
        bodyParsed: mapper(response.data));
  }

  @override
  Future<HttpResponse> post(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body}) async {
    body?.forEach((key, value) {
      if (value == null) body.remove(key);
    });
    final response = await dio.post(url,
        data: body,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries);
    return HttpResponse(
        body: response.data, statusCode: response.statusCode ?? 600);
  }

  @override
  Future<HttpResponseParsed<T>> postParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic> p1) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body}) async {
    body?.forEach((key, value) {
      if (value == null) body.remove(key);
    });
    final response = await dio.post(url,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries, data: body);
    return HttpResponseParsed(
        body: response.data,
        statusCode: response.statusCode ?? 600,
        bodyParsed: mapper(response.data));
  }

  @override
  Future<HttpResponse> put(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body}) async {
    body?.forEach((key, value) {
      if (value == null) body.remove(key);
    });
    final response = await dio.put(url,
        data: body,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries);
    return HttpResponse(
        body: response.data, statusCode: response.statusCode ?? 600);
  }

  @override
  Future<HttpResponseParsed<T>> putParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic> p1) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries,
      Map<String, dynamic>? body}) async {
    body?.forEach((key, value) {
      if (value == null) body.remove(key);
    });
    final response = await dio.post(url,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries, data: body);
    return HttpResponseParsed(
        body: response.data,
        statusCode: response.statusCode ?? 600,
        bodyParsed: mapper(response.data));
  }

  @override
  Future<HttpResponse> delete(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries}) async {
    final response = await dio.delete(url,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries);
    return HttpResponse(
        body: response.data, statusCode: response.statusCode ?? 600);
  }

  @override
  Future<HttpResponseParsed<T>> deleteParsed<T>(
      {required String url,
      required T Function(Map<String, dynamic> p1) mapper,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queries}) async {
    final response = await dio.delete(url,
        options: headers != null ? Options(headers: headers) : null,
        queryParameters: queries);
    return HttpResponseParsed(
        body: response.data,
        statusCode: response.statusCode ?? 600,
        bodyParsed: mapper(response.data));
  }
}
