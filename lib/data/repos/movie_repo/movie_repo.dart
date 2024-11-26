import 'package:dartz/dartz.dart';
import 'package:sahra/core/Errors/failures.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';

abstract class MovieRepo {
  Future<Either<Failure, List<MovieModel>>> getPopulerMovies({
    required int page,
    String? token,
  });
}
