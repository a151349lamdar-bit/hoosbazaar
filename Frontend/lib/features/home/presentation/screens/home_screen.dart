// صفحه اصلی برنامه
import 'package:flutter/material.dart';
import '../../../../core/fa_strings.dart';
import '../../../../core/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  // صفحات مختلف (بعدا تکمیل می‌شوند)
  static final List<Widget> _pages = [
    const _HomeTab(),
    const Placeholder(child: Center(child: Text('جستجو'))),
    const Placeholder(child: Center(child: Text('ثبت آگهی'))),
    const Placeholder(child: Center(child: Text('گفتگو'))),
    const Placeholder(child: Center(child: Text('پروفایل'))),
  ];
  
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(FaStrings.appName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontFamily: 'Vazir'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Vazir'),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: FaStrings.tabHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: FaStrings.tabSearch,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_rounded),
            label: 'ثبت آگهی',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: FaStrings.tabChat,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: FaStrings.tabProfile,
          ),
        ],
      ),
    );
  }
}

// تب خانه
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // سرچ باکس
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: FaStrings.hintSearch,
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          
          // دسته‌بندی‌ها
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _CategoryItem(
                  icon: Icons.directions_car_rounded,
                  label: FaStrings.categoryCars,
                  color: Colors.blue[100]!,
                ),
                _CategoryItem(
                  icon: Icons.home_work_rounded,
                  label: FaStrings.categoryRealEstate,
                  color: Colors.green[100]!,
                ),
                _CategoryItem(
                  icon: Icons.phone_iphone_rounded,
                  label: FaStrings.categoryDigital,
                  color: Colors.orange[100]!,
                ),
                _CategoryItem(
                  icon: Icons.chair_rounded,
                  label: FaStrings.categoryHome,
                  color: Colors.purple[100]!,
                ),
                _CategoryItem(
                  icon: Icons.design_services_rounded,
                  label: FaStrings.categoryServices,
                  color: Colors.red[100]!,
                ),
              ],
            ),
          ),
          
          // آگهی‌های ویژه
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'آگهی‌های ویژه',
                  style: TextStyle(
                    fontFamily: 'IranYekan',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'مشاهده همه',
                  style: TextStyle(
                    fontFamily: 'Vazir',
                    color: AppConstants.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          
          // لیست آگهی‌ها
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _AdListItem(index: index);
            },
          ),
        ],
      ),
    );
  }
}

// آیتم دسته‌بندی
class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  
  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(left: 8),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 30, color: Colors.grey[800]),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Vazir',
              fontSize: 12,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// آیتم آگهی
class _AdListItem extends StatelessWidget {
  final int index;
  
  const _AdListItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تصویر آگهی
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.photo_camera_back_rounded,
                size: 40,
                color: Colors.grey,
              ),
            ),
            
            const SizedBox(width: 12),
            
            // اطلاعات آگهی
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'پراید ۱۴۰۲ صفر کیلومتر',
                    style: TextStyle(
                      fontFamily: 'IranYekan',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    'تهران، ونک',
                    style: TextStyle(
                      fontFamily: 'Vazir',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FaStrings.formatPrice(450000000),
                        style: const TextStyle(
                          fontFamily: 'IranYekan',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      Text(
                        '۲ ساعت پیش',
                        style: TextStyle(
                          fontFamily: 'Vazir',
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
