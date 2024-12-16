import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';

class SimilerMovieItem extends StatelessWidget {
  const SimilerMovieItem({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45, // Fallback background color
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1.5, color: Colors.grey.withOpacity(.5)),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30), 
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    '${dotenv.env[kimagebaseurl]}${movie.posterPath!}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${movie.popularity.toString()}  ", style: const TextStyle(color: Colors.grey),),
                            const Icon(Icons.remove_red_eye , color: Colors.grey, )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
