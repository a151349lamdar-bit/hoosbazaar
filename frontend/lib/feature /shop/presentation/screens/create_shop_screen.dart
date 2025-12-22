// صفحه ایجاد فروشگاه
import 'package:flutter/material.dart';
import '../../../../core/fa_strings.dart';
import '../../../../core/app_constants.dart';
import '../../../../shared/widgets/persian_button.dart';
import '../../../../shared/widgets/persian_text_field.dart';

class CreateShopScreen extends StatefulWidget {
  const CreateShopScreen({super.key});

  @override
  State<CreateShopScreen> createState() => _CreateShopScreenState();
}

class _CreateShopScreenState extends State<CreateShopScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  String _selectedPlan = 'basic'; // basic, pro, enterprise
  String _selectedTheme = 'persian-blue';
  String _selectedMode = 'simple';
  
  final List<Map<String, dynamic>> _plans = [
    {
      'id': 'basic',
      'name': 'پلن پایه',
      'price': '۹۹,۰۰۰ تومان',
      'products': ۱۵,
      'features': ['ویترین ساده', 'پشتیبانی ایمیل', 'آمار مقدماتی'],
    },
    {
      'id': 'pro',
      'name': 'پلن حرفه‌ای',
      'price': '۱۹۹,۰۰۰ تومان',
      'products': ۳۰,
      'features': ['همه امکانات پایه', 'قالب‌های اختصاصی', 'کوپن تخفیف', 'آمار پیشرفته'],
    },
  ];
  
  final List<Map<String, dynamic>> _themes = [
    {'id': 'persian-blue', 'name': 'آبی پارسی', 'colors': ['#1B5E8E', '#4CAF50']},
    {'id': 'modern-red', 'name': 'قرمز مدرن', 'colors': ['#C62828', '#FF8A65']},
    {'id': 'minimalist-white', 'name': 'مینیمال سفید', 'colors': ['#FFFFFF', '#37474F']},
    {'id': 'dark-mode', 'name': 'حالت تاریک', 'colors': ['#121212', '#BB86FC']},
    {'id': 'green-nature', 'name': 'سبز طبیعت', 'colors': ['#2E7D32', '#81C784']},
  ];

  Future<void> _createShop() async {
    if (!_formKey.currentState!.validate()) return;
    
    final shopData = {
      'name': _nameController.text,
      'description': _descController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'plan': _selectedPlan,
      'theme': _selectedTheme,
      'mode': _selectedMode,
      'social_links': {
        'instagram': '',
        'telegram': '',
        'whatsapp': '',
      },
    };
    
    // TODO: ارسال به API
    print('فروشگاه ایجاد شد: $shopData');
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ایجاد فروشگاه جدید'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // هشدار ویژه
              Card(
                color: Colors.orange[50],
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.info_rounded, color: Colors.orange[800]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'فروشگاه‌ساز هوش‌بازار: ویترین آنلاین شما در ۲ دقیقه!',
                          style: TextStyle(
                            fontFamily: 'Vazir',
                            color: Colors.orange[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // نام فروشگاه
              PersianTextField(
                label: 'نام فروشگاه',
                hint: 'مثال: فروشگاه لوازم خانگی ستاره',
                controller: _nameController,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return 'نام باید حداقل ۳ کاراکتر باشد';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // توضیحات
              PersianTextField(
                label: 'توضیحات فروشگاه',
                hint: 'درباره فروشگاه خود توضیح دهید...',
                controller: _descController,
                maxLines: 3,
              ),
              
              const SizedBox(height: 16),
              
              // انتخاب پلن
              const Text(
                'انتخاب پلن فروشگاه',
                style: TextStyle(
                  fontFamily: 'IranYekan',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _plans.map((plan) {
                  final isSelected = _selectedPlan == plan['id'];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedPlan = plan['id']),
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected 
                              ? AppConstants.primaryColor 
                              : Colors.grey[300]!,
                          width: isSelected ? 3 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected 
                            ? AppConstants.primaryColor.withOpacity(0.05) 
                            : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan['name'],
                            style: TextStyle(
                              fontFamily: 'IranYekan',
                              fontWeight: FontWeight.bold,
                              color: isSelected 
                                  ? AppConstants.primaryColor 
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            plan['price'],
                            style: const TextStyle(
                              fontFamily: 'IranYekan',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${plan['products']} محصول',
                            style: TextStyle(
                              fontFamily: 'Vazir',
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...(plan['features'] as List).map((feature) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 16,
                                    color: isSelected 
                                        ? AppConstants.primaryColor 
                                        : Colors.green,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: TextStyle(
                                        fontFamily: 'Vazir',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // انتخاب قالب
              const Text(
                'انتخاب قالب فروشگاه',
                style: TextStyle(
                  fontFamily: 'IranYekan',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _themes.length,
                  itemBuilder: (context, index) {
                    final theme = _themes[index];
                    final isSelected = _selectedTheme == theme['id'];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTheme = theme['id']),
                      child: Container(
                        width: 90,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 0 : 8,
                          right: index == _themes.length - 1 ? 0 : 8,
                        ),
                        child: Column(
                          children: [
                            // پیش‌نمایش رنگ
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(int.parse(theme['colors'][0].replaceAll('#', '0xff'))),
                                    Color(int.parse(theme['colors'][1].replaceAll('#', '0xff'))),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected 
                                      ? AppConstants.primaryColor 
                                      : Colors.grey[300]!,
                                  width: isSelected ? 3 : 1,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check, color: Colors.white, size: 24)
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              theme['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Vazir',
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // حالت فروشگاه
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'حالت فروشگاه',
                        style: TextStyle(
                          fontFamily: 'IranYekan',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'حالت ساده برای شروع، حالت پیشرفته برای فروشگاه‌های حرفه‌ای',
                        style: TextStyle(
                          fontFamily: 'Vazir',
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildModeButton(
                              mode: 'simple',
                              icon: Icons.dashboard_rounded,
                              label: 'حالت ساده',
                              description: 'راه‌اندازی سریع\nمناسب برای شروع',
                              isSelected: _selectedMode == 'simple',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildModeButton(
                              mode: 'advanced',
                              icon: Icons.tune_rounded,
                              label: 'حالت پیشرفته',
                              description: 'امکانات کامل\nقالب سفارشی',
                              isSelected: _selectedMode == 'advanced',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // اطلاعات تماس
              PersianTextField(
                label: 'شماره تماس فروشگاه',
                hint: '۰۹۱۲۳۴۵۶۷۸۹',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              
              const SizedBox(height: 16),
              
              PersianTextField(
                label: 'آدرس فروشگاه (اختیاری)',
                hint: 'آدرس فیزیکی فروشگاه',
                controller: _addressController,
              ),
              
              const SizedBox(height: 32),
              
              // دکمه ایجاد
              PersianButton(
                text: 'ایجاد فروشگاه',
                onPressed: _createShop,
                icon: Icons.storefront_rounded,
                width: double.infinity,
              ),
              
              const SizedBox(height: 16),
              
              // توافق
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  Expanded(
                    child: Text(
                      'با قوانین و شرایط استفاده از سرویس فروشگاه‌ساز هوش‌بازار موافقت می‌کنم.',
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildModeButton({
    required String mode,
    required IconData icon,
    required String label,
    required String description,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedMode = mode),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected 
                ? AppConstants.primaryColor 
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected 
              ? AppConstants.primaryColor.withOpacity(0.05) 
              : Colors.white,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected 
                  ? AppConstants.primaryColor 
                  : Colors.grey[600],
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'IranYekan',
                fontWeight: FontWeight.bold,
                color: isSelected 
                    ? AppConstants.primaryColor 
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Vazir',
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
