// کلاینت HTTP برای API
import 'package:dio/dio.dart';
import 'app_constants.dart';
import 'fa_strings.dart';
import 'error_handler.dart';

class DioClient {
  late Dio _dio;
  
  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseUrl + AppConstants.apiVersion,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'fa-IR',
      },
    ));
    
    // افزودن interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // اینجا می‌توانی توکن را اضافه کنی
          // options.headers['Authorization'] = 'Bearer $token';
          print('🚀 درخواست: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onError: (error, handler) {
          print('❌ خطا: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }
  
  // GET
  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // POST
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // PUT
  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // DELETE
  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // آپلود فایل
  Future<Response> upload(String path, String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      
      final response = await _dio.post(
        path, 
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      
      return response;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
}
