import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  bool isEmail;
  final String? Function(String?)? validate;
  CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.isEmail = false,
    required  this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 400,
          height: 63,
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
            controller: controller,
            validator: validate,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.name,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white),
              alignLabelWithHint: true,
              hintTextDirection: TextDirection.ltr,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none, // no border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            style:
                const TextStyle(color: Colors.white), // Set text color to white
          )),
    );
  }
}
