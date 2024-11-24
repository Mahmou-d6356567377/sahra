import 'package:flutter/material.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:get_it/get_it.dart';

class MovieItem extends StatelessWidget {
  MovieItem(
      {super.key,
      required this.movieItemDetails,
      required this.height,
      required this.width});
  final MovieModel movieItemDetails;
  final double height;
  final double width;
  final GetIt getit = GetIt.instance;
 @override
Widget build(BuildContext context) {
  final double deviceHeight = MediaQuery.sizeOf(context).height;
  final double deviceWidth = MediaQuery.sizeOf(context).width;

  return GestureDetector(
    onTap: () {
      // Add your logic here
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(movieItemDetails.posterPath),
          _movieInfoWidget(deviceHeight, deviceWidth),
        ],
      ),
    ),
  );
}

Widget _moviePosterWidget(String? posterPath) {
  return Container(
    height: height,
    width: width * 0.80,
    decoration: BoxDecoration(
      color: Colors.grey[800]!.withOpacity(.5),
      image: DecorationImage(
        image: posterPath != null && posterPath.isNotEmpty 
            ? NetworkImage(posterPath)
            : const AssetImage('assets/images/tstimg.jpg') as ImageProvider,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _movieInfoWidget(double deviceHeight, double deviceWidth) {
  return SizedBox(
    height: deviceHeight * 0.2, 
    width: deviceWidth * 0.61, 
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                movieItemDetails.title!,
                style:  const TextStyle(color: Colors.white, fontWeight: FontWeight.w400,
                fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "${movieItemDetails.voteAverage}",
              style:  const TextStyle(color: Colors.white, fontWeight: FontWeight.w400,
                fontSize: 18,
                )    ,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: deviceHeight * 0.01),
          child: Text(
            '${movieItemDetails.originalLanguage!.toUpperCase()} | R: ${movieItemDetails.adult} | ${movieItemDetails.releaseDate}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: deviceHeight * 0.01),
          child: Text(
            movieItemDetails.overview ?? '',
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

}