// ثابت‌های مهم برنامه
class AppConstants {
  // نسخه برنامه
  static const String appVersion = '2.0.0';
  static const int buildNumber = 200;
  
  // تنظیمات پیش‌فرض
  static const int defaultPageSize = 20;
  static const int maxImageUpload = 10;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 2000;
  static const double minPrice = 0.0;
  static const double maxPrice = 1000000000000; // 1 تریلیون
  
  // زمان‌های کش
  static const int cacheTimeoutSeconds = 300; // 5 دقیقه
  static const int tokenRefreshBeforeSeconds = 300; // 5 دقیقه قبل از انقضا
  
  // محدودیت‌ها
  static const int maxLoginAttempts = 5;
  static const int lockoutDurationMinutes = 15;
  static const int maxAdsPerDay = 50;
  static const int maxMessagesPerHour = 100;
  
  // کلیدهای ذخیره‌سازی محلی
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String appSettingsKey = 'app_settings';
  static const String themeModeKey = 'theme_mode';
  static const String languageKey = 'app_language';
  
  // فرمت‌ها
  static const String dateFormat = 'yyyy/MM/dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy/MM/dd HH:mm';
  static const String priceFormat = '#,##0';
  
  // رنگ‌های ثابت
  static const int primaryColorValue = 0xFF2196F3;
  static const int secondaryColorValue = 0xFFFF9800;
  static const int successColorValue = 0xFF4CAF50;
  static const int errorColorValue = 0xFFF44336;
  static const int warningColorValue = 0xFFFFC107;
  
  // اندازه‌ها
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double cardElevation = 2.0;
  static const double buttonHeight = 48.0;
  
  // انیمیشن‌ها
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 250);
  
  // دسته‌بندی‌های اصلی
  static const List<Map<String, dynamic>> mainCategories = [
    {
      'id': 'real_estate',
      'name': 'املاک',
      'icon': 'home',
      'color': 0xFF2196F3,
      'subcategories': ['آپارتمان', 'ویلا', 'زمین', 'مغازه', 'اداری']
    },
    {
      'id': 'car',
      'name': 'خودرو',
      'icon': 'car',
      'color': 0xFFF44336,
      'subcategories': ['سواری', 'ون', 'کامیون', 'موتورسیکلت']
    },
    {
      'id': 'mobile',
      'name': 'موبایل',
      'icon': 'smartphone',
      'color': 0xFF4CAF50,
      'subcategories': ['گوشی', 'تبلت', 'لوازم جانبی']
    },
    {
      'id': 'electronics',
      'name': 'الکترونیک',
      'icon': 'tv',
      'color': 0xFF9C27B0,
      'subcategories': ['لپ‌تاپ', 'کامپیوتر', 'دوربین', 'صوتی و تصویری']
    },
    {
      'id': 'home',
      'name': 'خانه و آشپزخانه',
      'icon': 'kitchen',
      'color': 0xFFFF9800,
      'subcategories': ['مبلمان', 'لوازم آشپزخانه', 'دکوراسیون']
    },
    {
      'id': 'fashion',
      'name': 'مد و پوشاک',
      'icon': 'checkroom',
      'color': 0xFFE91E63,
      'subcategories': ['لباس زنانه', 'لباس مردانه', 'کفش', 'اکسسوری']
    },
  ];
  
  // شهرهای اصلی ایران
  static const List<String> mainCities = [
    'تهران',
    'مشهد',
    'اصفهان',
    'شیراز',
    'تبریز',
    'کرج',
    'قم',
    'اهواز',
    'کرمانشاه',
    'ارومیه',
    'رشت',
    'زاهدان',
    'کرمان',
    'همدان',
    'یزد',
    'اردبیل',
    'بندرعباس',
    'قزوین',
    'گرگان',
    'ساری',
  ];
  
  // واحدهای پولی
  static const Map<String, String> currencyUnits = {
    'IRR': 'ریال',
    'IRT': 'تومان',
  };
  
  // سطوح دسترسی
  static const Map<String, int> userLevels = {
    'user': 1,
    'verified': 2,
    'premium': 3,
    'admin': 99,
  };
  
  // وضعیت‌های آگهی
  static const Map<String, String> adStatus = {
    'draft': 'پیش‌نویس',
    'pending': 'در انتظار تأیید',
    'active': 'فعال',
    'sold': 'فروخته شده',
    'expired': 'منقضی شده',
    'rejected': 'رد شده',
  };
  
  // تنظیمات پیش‌فرض AI
  static const Map<String, dynamic> aiDefaults = {
    'confidence_threshold': 0.75,
    'max_similar_items': 100,
    'price_range_percentage': 15,
    'update_interval_hours': 24,
  };
}
