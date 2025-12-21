// آدرس‌های API سرور واقعی
class ApiEndpoints {
  static const String baseUrl = 'https://api.hoosbazaar.ir/v1';
  
  // احراز هویت
  static const String sendOtp = '$baseUrl/auth/send-otp';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String refreshToken = '$baseUrl/auth/refresh-token';
  
  // کاربران
  static const String profile = '$baseUrl/users/profile';
  static const String updateProfile = '$baseUrl/users/update';
  static const String uploadAvatar = '$baseUrl/users/upload-avatar';
  
  // آگهی‌ها
  static const String ads = '$baseUrl/ads';
  static String adDetail(String id) => '$baseUrl/ads/$id';
  static const String myAds = '$baseUrl/ads/my';
  static const String uploadAdImage = '$baseUrl/ads/upload-image';
  static const String searchAds = '$baseUrl/ads/search';
  
  // دسته‌بندی‌ها
  static const String categories = '$baseUrl/categories';
  static const String cities = '$baseUrl/cities';
  
  // چت
  static const String conversations = '$baseUrl/chat/conversations';
  static String messages(String chatId) => '$baseUrl/chat/$chatId/messages';
  static const String sendMessage = '$baseUrl/chat/send';
  
  // فروشگاه
  static const String shops = '$baseUrl/shops';
  static String shopDetail(String id) => '$baseUrl/shops/$id';
  static const String myShop = '$baseUrl/shops/my';
  static const String shopProducts = '$baseUrl/shops/products';
  
  // پرداخت
  static const String createPayment = '$baseUrl/payment/create';
  static const String verifyPayment = '$baseUrl/payment/verify';
  static const String transactions = '$baseUrl/payment/transactions';
  
  // تنظیمات
  static const String settings = '$baseUrl/settings';
  static const String contactUs = '$baseUrl/contact';
  
  // API Key برای سرویس‌های خارجی
  static const String mapApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String smsApiKey = 'YOUR_SMS_API_KEY';
}
