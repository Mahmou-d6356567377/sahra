import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  const PasswordTextField({
    super.key,
    required this.hintText,
    required this.controller,required  this.validate,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool notsecure = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Container(
        width: 400.h,
        height: 63.w,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 6,
              offset: const Offset(0, 3),
              spreadRadius: -6,
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.toString().isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
          obscureText: !notsecure,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            hintText: widget.hintText,
            hintTextDirection: TextDirection.ltr, // RTL hint text direction
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: IconButton(
              onPressed: () {
                setState(() {
                  notsecure = !notsecure;
                });
              },
              icon: notsecure
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
