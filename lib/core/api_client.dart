import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  final String refreshTokenUrl;

  ApiClient({required this.refreshTokenUrl})
      : _dio = Dio(),
        _storage = const FlutterSecureStorage() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
       
        final useToken = options.extra['useToken'] ?? true;
        if (useToken) {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
  if (error.response?.statusCode == 401) {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) {
      await _storage.deleteAll();
      return handler.reject(error);
    }

    try {
      final response = await _dio.post(refreshTokenUrl, data: {
        'refresh_token': refreshToken,
      });

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

    
      await _storage.write(key: 'access_token', value: newAccessToken);

    
      if (newRefreshToken != null) {
        await _storage.write(key: 'refresh_token', value: newRefreshToken);
      }

     
      final retryRequest = error.requestOptions;
      retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await _dio.fetch(retryRequest);

      return handler.resolve(retryResponse);
    } catch (e) {
      await _storage.deleteAll(); // refresh token cũng thất bại → logout
      return handler.reject(error);
    }
  }

  return handler.next(error); 
}

    ));
  }

  // GET
  Future<Response> getRequest(
    String path, {
    Map<String, dynamic>? params,
    bool useToken = true,
  }) {
    return _dio.get(
      path,
      queryParameters: params,
      options: Options(extra: {'useToken': useToken}),
    );
  }

  // POST
  Future<Response> postRequest(
    String path, {
    Map<String, dynamic>? body,
    bool useToken = true,
  }) {
    return _dio.post(
      path,
      data: body,
      options: Options(extra: {'useToken': useToken}),
    );
  }

  // PATCH
  Future<Response> patchRequest(
    String path, {
    Map<String, dynamic>? body,
    bool useToken = true,
  }) {
    return _dio.patch(
      path,
      data: body,
      options: Options(extra: {'useToken': useToken}),
    );
  }

  // DELETE
  Future<Response> deleteRequest(
    String path, {
    Map<String, dynamic>? body,
    bool useToken = true,
  }) {
    return _dio.delete(
      path,
      data: body,
      options: Options(extra: {'useToken': useToken}),
    );
  }
}
