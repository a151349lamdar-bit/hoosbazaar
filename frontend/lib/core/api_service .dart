import 'dart:convert';
import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'error_handler.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient;
  
  ApiService(this._dioClient);
  
  // 🔐 احراز هویت
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
          'device_name': 'mobile_app',
        },
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        data: userData,
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<void> logout() async {
    try {
      await _dioClient.post(ApiEndpoints.logout);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  // 📊 آگهی‌ها
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
      
      final response = await _dioClient.get(
        ApiEndpoints.adsList,
        queryParameters: params,
      );
      return response.data['data'];
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<Map<String, dynamic>> createAd(Map<String, dynamic> adData) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.createAd,
        data: adData,
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<Map<String, dynamic>> getAdDetail(String adId) async {
    try {
      final response = await _dioClient.get(
        '${ApiEndpoints.adDetail}/$adId',
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<List<dynamic>> getMyAds() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.myAds);
      return response.data['data'];
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  // 🤖 قیمت‌گذاری هوشمند
  Future<Map<String, dynamic>> getAIPriceSuggestion({
    required String category,
    required Map<String, dynamic> itemDetails,
    required String location,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.aiPricing,
        data: {
          'category': category,
          'item_details': itemDetails,
          'location': location,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<Map<String, dynamic>> getMarketAnalysis(String category) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.marketAnalysis,
        queryParameters: {'category': category},
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  // 📁 آپلود فایل
  Future<String> uploadImage(String imagePath) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath),
      });
      
      final response = await _dioClient.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      return response.data['url'];
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<List<String>> uploadMultipleImages(List<String> imagePaths) async {
    try {
      final formData = FormData();
      
      for (var i = 0; i < imagePaths.length; i++) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(imagePaths[i]),
        ));
      }
      
      final response = await _dioClient.post(
        ApiEndpoints.uploadMultiple,
        data: formData,
      );
      return List<String>.from(response.data['urls']);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  // 👤 پروفایل کاربر
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.userProfile);
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<Map<String, dynamic>> updateUserProfile(Map<String, dynamic> profileData) async {
    try {
      final response = await _dioClient.put(
        ApiEndpoints.updateProfile,
        data: profileData,
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  // 📊 آمار
  Future<Map<String, dynamic>> getUserStats() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.userStats);
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  // 🔍 جستجو
  Future<List<dynamic>> searchAds(String query, {int page = 1}) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.searchAds,
        queryParameters: {
          'q': query,
          'page': page,
          'limit': 20,
        },
      );
      return response.data['data'];
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  // 📱 تنظیمات
  Future<Map<String, dynamic>> getAppSettings() async {
    try {
      final response = await _dioClient.get(ApiEndpoints.appSettings);
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
  
  Future<Map<String, dynamic>> updateUserSettings(Map<String, dynamic> settings) async {
    try {
      final response = await _dioClient.put(
        ApiEndpoints.userSettings,
        data: settings,
      );
      return response.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
