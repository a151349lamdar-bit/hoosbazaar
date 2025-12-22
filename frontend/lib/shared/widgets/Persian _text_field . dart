// فیلد متن فارسی با اعتبارسنجی
import 'package:flutter/material.dart';

class PersianTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? errorText;
  final Widget? suffixIcon;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  
  const PersianTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.suffixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // برچسب
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              fontFamily: 'IranYekan',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 8),
        
        // فیلد متن
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          onChanged: onChanged,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: 'Vazir',
              color: Colors.grey,
            ),
            errorText: errorText,
            errorStyle: const TextStyle(
              fontFamily: 'Vazir',
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF1B5E8E),
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines == 1 ? 0 : 16,
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Vazir',
            fontSize: 16,
          ),
        ),
        
        const SizedBox(height: 4),
      ],
    );
  }
}
