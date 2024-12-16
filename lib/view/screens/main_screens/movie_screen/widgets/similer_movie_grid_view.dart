import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sahra/bloc/get_movie_details_cubit/get_movie_details_cubit.dart';
import 'package:sahra/bloc/similer_movie_cubit/similermovies_cubit.dart';
import 'package:sahra/core/routes/app_routes.dart';
import 'package:sahra/view/screens/main_screens/movie_screen/widgets/similer_movie_item.dart';

class SimilerMovieGridView extends StatefulWidget {
  const SimilerMovieGridView({super.key, required this.movieId});
  final int movieId;

  @override
  State<SimilerMovieGridView> createState() => _SimilerMovieGridViewState();
}

class _SimilerMovieGridViewState extends State<SimilerMovieGridView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SimilermoviesCubit>(context)
        .fetchSimilerMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilermoviesCubit, SimilermoviesState>(
      builder: (context, state) {
        if (state is SimilermoviesFailure) {
          return Center(
            child: Text('Error: ${state.errmsg}'), // Error handling
          );
        } else if (state is SimilermoviesSuccess) {
          final movies = state.similerMovies;
          if (movies.isEmpty) {
            return const Center(
              child: Text('No similar movies found'), // When no movies are found
            );
          }

          return ListView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: movies.length,
             itemBuilder: (context, index) {
               final movie = movies[index];
               return SizedBox(
                 width: 200, // Explicit width for each item
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<GetMovieDetailsCubit>(context)
                         .fetchTopRatedMovies(movie.id!);
                     GoRouter.of(context).push(AppRoutes.ms2,);
      },
                    child: SimilerMovieItem(movie: movie)),
                 ),
               );
             },
           );

        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(), // Loading indicator
          );
        }
      },
    );
  }
}
