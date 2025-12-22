// موجودیت فروشگاه
class ShopEntity {
  final String id;
  final String userId;
  final String name;
  final String slug;
  final String? description;
  final String? logoUrl;
  final String? bannerUrl;
  final String? phone;
  final String? email;
  final String? address;
  final String? city;
  final Map<String, dynamic>? socialLinks;
  final String theme;
  final String mode; // 'simple' یا 'advanced'
  final int productLimit;
  final int currentProducts;
  final double rating;
  final int totalSales;
  final bool isVerified;
  final bool isActive;
  final bool isPremium;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const ShopEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.slug,
    this.description,
    this.logoUrl,
    this.bannerUrl,
    this.phone,
    this.email,
    this.address,
    this.city,
    this.socialLinks,
    this.theme = 'default',
    this.mode = 'simple',
    this.productLimit = 15,
    this.currentProducts = 0,
    this.rating = 0.0,
    this.totalSales = 0,
    this.isVerified = false,
    this.isActive = true,
    this.isPremium = false,
    required this.createdAt,
    this.updatedAt,
  });
  
  // تبدیل به Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'slug': slug,
      'description': description,
      'logo_url': logoUrl,
      'banner_url': bannerUrl,
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'social_links': socialLinks,
      'theme': theme,
      'mode': mode,
      'product_limit': productLimit,
      'current_products': currentProducts,
      'rating': rating,
      'total_sales': totalSales,
      'is_verified': isVerified,
      'is_active': isActive,
      'is_premium': isPremium,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
  
  // ایجاد از Map
  factory ShopEntity.fromMap(Map<String, dynamic> map) {
    return ShopEntity(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'],
      logoUrl: map['logo_url'],
      bannerUrl: map['banner_url'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      socialLinks: map['social_links'] is Map ? Map<String, dynamic>.from(map['social_links']) : null,
      theme: map['theme'] ?? 'default',
      mode: map['mode'] ?? 'simple',
      productLimit: map['product_limit'] ?? 15,
      currentProducts: map['current_products'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      totalSales: map['total_sales'] ?? 0,
      isVerified: map['is_verified'] ?? false,
      isActive: map['is_active'] ?? true,
      isPremium: map['is_premium'] ?? false,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
