import 'package:dartz/dartz.dart';
import 'package:sahra/core/Errors/failures.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/models/movie_page_model/movie_page_model.dart';

abstract class MovieRepo {
  Future<Either<Failure, List<MovieModel>>> getPopulerMovies({
    required int page,
    String? token,
  });
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies();
  Future<Either<Failure, List<MovieModel>>> getUpcomingMovies();
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies();
  Future<Either<Failure, MoviePageModel>> getMovieDetails(int movieId);
  Future<Either<Failure, List<MovieModel>>> getSimilerMovies(int movieId);
  Future<Either<Failure, List<MovieModel>>> getSearchedMovies({
    required String moviename,
    required int page,
    required String language,
    required bool adult,
  });
}
