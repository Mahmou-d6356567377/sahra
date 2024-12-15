import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/core/routes/app_routes.dart';

class ExploreRatingWidget extends StatelessWidget {
  const ExploreRatingWidget({
    super.key,
    required this.rate,
    required this.url,
  });
  final double rate;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Web navigation button
          ElevatedButton.icon(
            onPressed: () {
              GoRouter.of(context).push(AppRoutes.ws, extra: url);
            },
            icon: const Icon(
              Icons.language,
              color: Colors.white70,
            ), // Icon for the button
            label: const Text(
              "YOUTUBE",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.black.withOpacity(.8),
            ),
          ),

          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20, // Icon size
              ),
              const SizedBox(width: 5), // Spacing between star and text
              Text(
                '$rate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
