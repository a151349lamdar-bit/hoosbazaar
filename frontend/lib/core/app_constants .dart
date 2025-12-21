// تنظیمات و ثابت‌های اصلی برنامه
import 'package:flutter/material.dart';

class AppConstants {
  // رنگ‌های اصلی - پالت فارسی
  static const Color primaryColor = Color(0xFF1B5E8E); // آبی ایرانی
  static const Color secondaryColor = Color(0xFF4CAF50); // سبز
  static const Color accentColor = Color(0xFFFF9800); // نارنجی
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color textColor = Color(0xFF37474F);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  
  // API و آدرس‌ها
  static const String apiBaseUrl = 'https://api.hoosbazaar.ir';
  static const String apiVersion = '/v1';
  
  // تنظیمات برنامه
  static const int maxAdImages = 6;
  static const int otpTimeoutSeconds = 120;
  static const int itemsPerPage = 20;
  
  // کلیدهای ذخیره‌سازی
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String appLanguageKey = 'app_language';
  
  // نقشه
  static const double defaultMapZoom = 12.0;
  static const String mapApiKey = 'YOUR_GOOGLE_MAPS_KEY'; // بعدا جایگزین کن
}
