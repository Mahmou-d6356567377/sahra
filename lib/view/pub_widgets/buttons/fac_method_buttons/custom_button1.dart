import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahra/core/constants/font_constant.dart';
import 'package:sahra/view/pub_widgets/buttons/fac_method_buttons/abstract_buttons_class.dart';


class CustomButton1 implements CustomButton{
  @override
  Widget button(String title, VoidCallback onpressed) {
     return Container(
      margin:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      width: 1.sw,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:  Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          title,
          style:
              mainfont1.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}