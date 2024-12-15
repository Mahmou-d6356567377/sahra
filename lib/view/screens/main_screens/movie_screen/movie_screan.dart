import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/bloc/get_movie_details_cubit/get_movie_details_cubit.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/data/models/movie_page_model/movie_page_model.dart';
import 'package:sahra/view/screens/main_screens/movie_screen/widgets/explore&ratingWidget.dart';
import 'package:sahra/view/screens/main_screens/movie_screen/widgets/overView_widget.dart';
import 'package:sahra/view/screens/main_screens/movie_screen/widgets/similer_movie_grid_view.dart';

class MovieScrean extends StatelessWidget {
  const MovieScrean({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: BlocBuilder<GetMovieDetailsCubit, GetMovieDetailsState>(
        builder: (context, state) {
          if (state is GetMovieDetailsSuccess) {
            return _successBody(context, state.movieDetails, height, width);
          } else if (state is GetMovieDetailsFailure) {
            return Center(
              child: Text(state.errMsg),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }


  Widget _backgroundWidget(String img) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image:  DecorationImage(
            fit: BoxFit.cover, image: NetworkImage("${dotenv.env[kimagebaseurl]}$img")),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(.2)),
        ),
      ),
    );
  }
  
  Widget _successBody(BuildContext context, 
      MoviePageModel movieDetails, double height, double width) {
    return Stack(
      children: [
        _backgroundWidget(movieDetails.backdropPath!),
        Column(
          children: [
            _imgWidget(context, height, width, movieDetails.backdropPath!),
            _title(movieDetails.title!),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MovieOverview(overview: movieDetails.overview!),
                    _secondRow(
                      movieDetails.originCountry![0],
                      movieDetails.originalLanguage!.toUpperCase(),
                      movieDetails.popularity.toString(),
                    ),
                    ExploreRatingWidget(
                      rate: movieDetails.voteAverage!,
                      url:
                          'https://www.youtube.com/results?search_query=${movieDetails.title}',
                    ),
                    _thirdRow(),
                    SizedBox(
                      height: 250, 
                      child: SimilerMovieGridView(
                        movieId: movieDetails.id!,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _imgWidget(
      BuildContext context, double height, double width, String imgpath) {
    return Stack(
      children: [
        Container(
          height: height * 0.4,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("${dotenv.env[kimagebaseurl]}$imgpath"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 40.0,
          left: 12.0,
          child: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget _secondRow(String country, String language, String popularity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$country : $language'),
          Row(
            children: [
              Text(popularity),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.remove_red_eye),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _thirdRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Row(
        children: [
          Text(
            'Similer Movies',
            style: TextStyle(
              fontFamily: kmainfont,
              fontSize: 20,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: kmainfont,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
