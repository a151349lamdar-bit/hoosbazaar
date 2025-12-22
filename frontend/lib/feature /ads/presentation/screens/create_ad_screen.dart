import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../../core/fa_strings.dart';
import '../../../core/app_constants.dart';
import '../../../shared/widgets/persian_button.dart';
import '../../../shared/widgets/persian_text_field.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String _selectedCategory = 'خودرو';
  String _selectedCity = 'تهران';
  String _condition = 'نو';
  List<XFile> _selectedImages = [];
  
  final List<String> _categories = [
    'خودرو', 'املاک', 'موبایل', 'لپ‌تاپ', 
    'وسایل خانه', 'پوشاک', 'خدمات', 'متفرقه'
  ];
  
  final List<String> _cities = [
    'تهران', 'مشهد', 'اصفهان', 'شیراز', 'تبریز',
    'کرج', 'اهواز', 'قم', 'کرمانشاه', 'رشت'
  ];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage(
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    
    if (images != null) {
      setState(() {
        _selectedImages.addAll(images);
        if (_selectedImages.length > 6) {
          _selectedImages = _selectedImages.sublist(0, 6);
        }
      });
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 90,
    );
    
    if (image != null) {
      setState(() {
        if (_selectedImages.length < 6) {
          _selectedImages.add(image);
        }
      });
    }
  }

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حداقل یک عکس انتخاب کنید'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    // TODO: ارسال به سرور
    final adData = {
      'title': _titleController.text,
      'price': int.parse(_priceController.text.replaceAll(',', '')),
      'description': _descController.text,
      'category': _selectedCategory,
      'city': _selectedCity,
      'condition': _condition,
      'phone': _phoneController.text,
      'images_count': _selectedImages.length,
    };
    
    print('آگهی ثبت شد: $adData');
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت آگهی جدید'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('راهنمای ثبت آگهی'),
                  content: const Text(
                    '• عنوان واضح و کامل بگذارید\n'
                    '• قیمت واقعی تعیین کنید\n'
                    '• حداقل ۳ عکس با کیفیت اضافه کنید\n'
                    '• توضیحات کامل بنویسید\n'
                    '• شماره تماس صحیح وارد کنید',
                    style: TextStyle(fontFamily: 'Vazir'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('متوجه شدم'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بخش عکس‌ها
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'عکس‌های آگهی',
                        style: TextStyle(
                          fontFamily: 'IranYekan',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'حداقل ۱ و حداکثر ۶ عکس (${_selectedImages.length}/۶)',
                        style: TextStyle(
                          fontFamily: 'Vazir',
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // گالری عکس‌ها
                      if (_selectedImages.isNotEmpty)
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(_selectedImages[index].path),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    icon: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedImages.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      
                      const SizedBox(height: 16),
                      
                      // دکمه‌های آپلود
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _pickImages,
                              icon: const Icon(Icons.photo_library_rounded),
                              label: const Text('از گالری'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _takePhoto,
                              icon: const Icon(Icons.camera_alt_rounded),
                              label: const Text('دوربین'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // عنوان
              PersianTextField(
                label: 'عنوان آگهی',
                hint: 'مثال: پراید ۱۴۰۲ صفر کیلومتر',
                controller: _titleController,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'عنوان باید حداقل ۵ کاراکتر باشد';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // دسته‌بندی و شهر
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'دسته‌بندی',
                          style: TextStyle(
                            fontFamily: 'IranYekan',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          items: _categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category, style: const TextStyle(fontFamily: 'Vazir')),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedCategory = value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'شهر',
                          style: TextStyle(
                            fontFamily: 'IranYekan',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedCity,
                          items: _cities.map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city, style: const TextStyle(fontFamily: 'Vazir')),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedCity = value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // قیمت و وضعیت
              Row(
                children: [
                  Expanded(
                    child: PersianTextField(
                      label: 'قیمت (تومان)',
                      hint: 'مثال: ۵۰۰۰۰۰۰۰',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'قیمت را وارد کنید';
                        }
                        final price = int.tryParse(value.replaceAll(',', ''));
                        if (price == null || price < 1000) {
                          return 'قیمت معتبر نیست';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          final numeric = value.replaceAll(',', '');
                          final formatted = numeric.seRagham();
                          if (formatted != value) {
                            _priceController.value = TextEditingValue(
                              text: formatted,
                              selection: TextSelection.collapsed(
                                offset: formatted.length,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'وضعیت کالا',
                          style: TextStyle(
                            fontFamily: 'IranYekan',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _condition,
                          items: ['نو', 'در حد نو', 'کارکرده'].map((condition) {
                            return DropdownMenuItem(
                              value: condition,
                              child: Text(condition, style: const TextStyle(fontFamily: 'Vazir')),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _condition = value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // توضیحات
              PersianTextField(
                label: 'توضیحات کامل',
                hint: 'مشخصات، شرایط، آدرس و ...',
                controller: _descController,
                maxLines: 4,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.length < 20) {
                    return 'توضیحات باید حداقل ۲۰ کاراکتر باشد';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // شماره تماس
              PersianTextField(
                label: 'شماره تماس',
                hint: '۰۹۱۲۳۴۵۶۷۸۹',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.length != 11) {
                    return 'شماره باید ۱۱ رقم باشد';
                  }
                  if (!value.startsWith('09')) {
                    return 'شماره با ۰۹ شروع شود';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 32),
              
              // دکمه ثبت
              PersianButton(
                text: 'ثبت آگهی',
                onPressed: _submitAd,
                icon: Icons.check_circle_rounded,
                width: double.infinity,
              ),
              
              const SizedBox(height: 16),
              
              // نکات
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💡 نکات مهم:',
                        style: TextStyle(
                          fontFamily: 'IranYekan',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• آگهی بعد از تأیید منتشر می‌شود\n'
                        '• شماره تماس برای خریداران نمایش داده می‌شود\n'
                        '• می‌توانید بعداً آگهی را ویرایش یا حذف کنید\n'
                        '• در صورت مشکل با پشتیبانی تماس بگیرید',
                        style: TextStyle(
                          fontFamily: 'Vazir',
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
