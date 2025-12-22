// سرویس ارتباط با API سرور واقعی
import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  late Dio _dio;
  static final ApiService _instance = ApiService._internal();
  
  factory ApiService() => _instance;
  
  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'fa-IR',
      },
    ));
    
    _setupInterceptors();
  }
  
  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // افزودن توکن به هدر
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        
        print('📤 ارسال درخواست: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('📥 دریافت پاسخ: ${response.statusCode}');
        return handler.next(response);
      },
      onError: (error, handler) {
        print('❌ خطای API: ${error.response?.statusCode}');
        
        // بررسی خطای 401 (عدم احراز هویت)
        if (error.response?.statusCode == 401) {
          // TODO: رفرش توکن یا هدایت به صفحه لاگین
        }
        
        return handler.next(error);
      },
    ));
  }
  
  // احراز هویت
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.sendOtp,
        data: {'phone': phone},
      );
      return response.data;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.verifyOtp,
        data: {'phone': phone, 'code': code},
      );
      
      // ذخیره توکن
      if (response.data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.data['token']);
        await prefs.setString('refresh_token', response.data['refresh_token']);
        await prefs.setString('user_id', response.data['user_id']);
      }
      
      return response.data;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // آگهی‌ها
  Future<Map<String, dynamic>> createAd(Map<String, dynamic> adData) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.ads,
        data: adData,
      );
      return response.data;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  Future<List<dynamic>> getAds({
    int page = 1,
    int limit = 20,
    String? category,
    String? city,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final params = {
        'page': page,
        'limit': limit,
        if (category != null) 'category': category,
        if (city != null) 'city': city,
        if (minPrice != null) 'min_price': minPrice,
        if (maxPrice != null) 'max_price': maxPrice,
      };
      
      final response = await _dio.get(
        ApiEndpoints.ads,
        queryParameters: params,
      );
      return response.data['data'];
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // آپلود عکس
  Future<String> uploadImage(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      
      final response = await _dio.post(
        ApiEndpoints.uploadAdImage,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      
      return response.data['url'];
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // فروشگاه
  Future<Map<String, dynamic>> createShop(Map<String, dynamic> shopData) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.shops,
        data: shopData,
      );
      return response.data;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  Future<Map<String, dynamic>> getMyShop() async {
    try {
      final response = await _dio.get(ApiEndpoints.myShop);
      return response.data;
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // جستجو
  Future<List<dynamic>> search(String query) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.searchAds,
        queryParameters: {'q': query},
      );
      return response.data['data'];
    } catch (e) {
      throw PersianErrorHandler.translate(e);
    }
  }
  
  // وضعیت اتصال
  Future<bool> checkConnection() async {
    try {
      await _dio.get('${ApiEndpoints.baseUrl}/health');
      return true;
    } catch (e) {
      return false;
    }
  }
}
