// مدیریت محصولات فروشگاه
import 'package:flutter/material.dart';
import '../../../../core/fa_strings.dart';

class ShopProductsScreen extends StatelessWidget {
  const ShopProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محصولات فروشگاه'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text(
          'لیست محصولات فروشگاه',
          style: TextStyle(fontFamily: 'Vazir'),
        ),
      ),
    );
  }
}
