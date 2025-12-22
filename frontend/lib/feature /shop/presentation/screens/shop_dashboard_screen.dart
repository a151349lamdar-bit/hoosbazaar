// داشبورد مدیریت فروشگاه
import 'package:flutter/material.dart';
import '../../../../core/fa_strings.dart';

class ShopDashboardScreen extends StatelessWidget {
  const ShopDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('داشبورد فروشگاه'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'داشبورد فروشگاه - به زودی',
          style: TextStyle(fontFamily: 'Vazir'),
        ),
      ),
    );
  }
}
