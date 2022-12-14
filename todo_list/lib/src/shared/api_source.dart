import 'package:todo_list/src/features/auth/application/token_service.dart';
import 'package:todo_list/src/shared/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseApiSource {
  BaseApiSource(
    Dio dio,
    CurrentToken token
  ) : _dio = dio, 
    _token = token;

  final Dio _dio;
  final CurrentToken _token;
 
  static String baseUrl = "http://192.168.0.105:8000";

  Future<Response<T>> get<T>(String endpoint, { 
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get<T>(_url(endpoint), 
      queryParameters: queryParameters, 
      options: await _tokenizedOptions
    );
  }

  Future<Response<T>> post<T>(String endpoint, { 
    Map<String, dynamic>? queryParameters, dynamic data 
  }) async {
    return _dio.post<T>(_url(endpoint),
      queryParameters: queryParameters,
      data: data,
      options: await _tokenizedOptions,
    );
  }

  Future<Response<T>> put<T>(String endpoint, {
    Map<String, dynamic>? queryParamenters, dynamic data,
  }) async {
    return _dio.put<T>(_url(endpoint), 
      queryParameters: queryParamenters,
      options: await _tokenizedOptions,
    );
  }

  _url(String endpoint) => "$baseUrl$endpoint";

  Future<Options> get _tokenizedOptions async {
    String token = await _token();
    return Options(
      headers: {
        "token": token
      }
    );
  }
}

final baseApiSourceProvider = Provider((ref) {
  CurrentToken token = ref.watch(currentTokenProvider);
  Dio dio = ref.watch(dioProvider);
  return BaseApiSource(dio, token);
});