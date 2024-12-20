import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/data/models/movie_page_model/movie_page_model.dart';

class CustomFavButton extends StatefulWidget {
  const CustomFavButton({
    super.key,
    required this.movieDetails,
  });

  final MoviePageModel movieDetails;

  @override
  State<CustomFavButton> createState() => _CustomFavButtonState();
}

class _CustomFavButtonState extends State<CustomFavButton> {
  late Box<MoviePageModel> favoritesBox;
  bool isFav = false;

  // Open the Hive box for favorites
  Future<void> _openHiveBox() async {
    favoritesBox = await Hive.openBox<MoviePageModel>(kboxname);
    setState(() {
      // Check if the movie ID is already in the box
      isFav = favoritesBox.containsKey(widget.movieDetails.id);
    });
  }

  @override
  void initState() {
    super.initState();
    _openHiveBox(); // Ensure the box is opened when the widget is initialized
  }

  void _printFavorites() {
    for (var key in favoritesBox.keys) {
      var movie = favoritesBox.get(key);
      print('Movie ID: $key, Movie Details: ${movie!.originalTitle}   .............${movie.posterPath}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Directly return the FloatingActionButton after the Hive box is initialized
    return FloatingActionButton(
      backgroundColor: Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      onPressed: () async {
        setState(() {
          _printFavorites();
          if (isFav) {
            favoritesBox.delete(widget.movieDetails.id); // Remove from Hive
          } else {
            favoritesBox.put(
                widget.movieDetails.id, widget.movieDetails); // Add to Hive
          }
          isFav = !isFav; // Toggle the favorite status
        });
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : Colors.white,
      ),
    );
  }
}
