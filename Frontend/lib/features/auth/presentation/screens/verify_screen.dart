// صفحه تأیید کد OTP
import 'package:flutter/material.dart';
import '../../../../core/fa_strings.dart';
import '../../../../core/app_constants.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  
  const VerifyScreen({super.key, required this.phoneNumber});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final List<TextEditingController> _controllers = 
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;
  int _countdown = FaStrings.otpTimeoutSeconds;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    
    // تنظیم فوکوس خودکار بین کادرها
    for (int i = 0; i < 5; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < 5) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _countdown > 0) {
        setState(() => _countdown--);
        _startCountdown();
      }
    });
  }

  Future<void> _verifyCode() async {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // شبیه‌سازی API
    setState(() => _isLoading = false);
    
    // در اینجا باید API واقعی فراخوانی شود
    Navigator.pushReplacementNamed(context, '/home');
  }

  Future<void> _resendCode() async {
    setState(() {
      _countdown = FaStrings.otpTimeoutSeconds;
      _controllers.forEach((c) => c.clear());
    });
    _startCountdown();
    _focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تأیید شماره'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // توضیح
            Text(
              'کد تأیید برای ${widget.phoneNumber} ارسال شد',
              style: const TextStyle(
                fontFamily: 'Vazir',
                fontSize: 16,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'لطفا کد ۶ رقمی را وارد کنید',
              style: TextStyle(
                fontFamily: 'Vazir',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // کادرهای کد OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(
                      fontFamily: 'IranYekan',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppConstants.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 24),
            
            // تایمر
            Center(
              child: Text(
                'زمان باقی‌مانده: $_countdown ثانیه',
                style: const TextStyle(
                  fontFamily: 'Vazir',
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // دکمه تأیید
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'تأیید و ادامه',
                        style: TextStyle(
                          fontFamily: 'Vazir',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // دکمه ارسال مجدد
            Center(
              child: TextButton(
                onPressed: _countdown > 0 ? null : _resendCode,
                child: Text(
                  'ارسال مجدد کد',
                  style: TextStyle(
                    fontFamily: 'Vazir',
                    fontSize: 16,
                    color: _countdown > 0 
                        ? Colors.grey 
                        : AppConstants.primaryColor,
                  ),
                ),
              ),
            ),
            
            const Spacer(),
            
            // مشکل در دریافت کد
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'شماره را اشتباه وارد کردم',
                  style: TextStyle(
                    fontFamily: 'Vazir',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
