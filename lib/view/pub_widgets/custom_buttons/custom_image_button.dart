import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
  const CustomImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Circular Image Button Tapped!");
        // Add your action here
      },
      child: ClipOval(
        child: Image.network(
          'https://via.placeholder.com/150',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
