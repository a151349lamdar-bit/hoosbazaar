// موجودیت آگهی
class AdEntity {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double price;
  final String category;
  final String city;
  final String condition;
  final List<String> images;
  final String phone;
  final int viewCount;
  final int likeCount;
  final bool isActive;
  final bool isFeatured;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  AdEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.city,
    required this.condition,
    required this.images,
    required this.phone,
    this.viewCount = 0,
    this.likeCount = 0,
    this.isActive = true,
    this.isFeatured = false,
    required this.createdAt,
    this.updatedAt,
  });
  
  // قیمت با فرمت فارسی
  String get formattedPrice {
    return '${price.toStringAsFixed(0).seRagham()} تومان';
  }
  
  // زمان نسبی
  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    
    if (diff.inSeconds < 60) return 'همین الان';
    if (diff.inMinutes < 60) return '${diff.inMinutes} دقیقه پیش';
    if (diff.inHours < 24) return '${diff.inHours} ساعت پیش';
    if (diff.inDays < 7) return '${diff.inDays} روز پیش';
    
    return '${createdAt.year}/${createdAt.month}/${createdAt.day}';
  }
}
