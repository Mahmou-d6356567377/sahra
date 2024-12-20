import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sahra/core/constants/constants_properties.dart';

class MovieCard extends StatelessWidget {
  final int id;
  final String image;
  final String description;

  const MovieCard({super.key, required this.image, required this.description , required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        spacing: 2,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                    image.isNotEmpty
                    ? "${dotenv.env[kimagebaseurl]}$image"
                    : "https://via.placeholder.com/150", 
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, color: Colors.grey,size: 30,)),
                  )
                  
            ),
          ),
          Text(
            description,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
