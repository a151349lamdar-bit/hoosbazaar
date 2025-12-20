// منطق کسب‌وکار احراز هویت
import 'package:flutter/foundation.dart';
import '../../../core/error_handler.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // شبیه‌سازی ارسال OTP
  Future<bool> sendOtp(String phone) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2)); // شبیه‌سازی تاخیر شبکه
    
    // در اینجا باید API واقعی فراخوانی شود
    if (phone.length != 11) {
      _errorMessage = 'شماره موبایل نامعتبر است';
      _isLoading = false;
      notifyListeners();
      return false;
    }
    
    _isLoading = false;
    notifyListeners();
    return true;
  }
  
  // شبیه‌سازی تأیید کد
  Future<bool> verifyOtp(String phone, String code) async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2));
    
    // در اینجا باید API واقعی فراخوانی شود
    if (code.length != 6) {
      _errorMessage = 'کد تأیید باید ۶ رقم باشد';
      _isLoading = false;
      notifyListeners();
      return false;
    }
    
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
