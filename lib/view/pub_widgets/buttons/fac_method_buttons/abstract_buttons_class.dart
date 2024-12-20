import 'package:flutter/material.dart';

abstract class CustomButton {
  Widget button(
    String title,
    VoidCallback onpressed,
  );
}
