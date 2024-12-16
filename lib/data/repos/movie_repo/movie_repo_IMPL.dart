import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sahra/core/Errors/failures.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/models/movie_page_model/movie_page_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';
import 'package:sahra/data/sources/API/api_service.dart';
import 'package:dio/dio.dart'; // Import Dio for network-related exceptions

class MovieRepoImpl implements MovieRepo {
  final ApiService apiService;

  MovieRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<MovieModel>>> getPopulerMovies({
    required int page,
    String? token,
  }) async {
    try {
      final response = await apiService.get(
        url:
            '${dotenv.env[kbaseUrl]}popular?api_key=${dotenv.env[kapiKey]}&language=en-US&page=$page',
      );

      if (response.containsKey('results')) {
        final List<MovieModel> movies = (response['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return right(movies);
      } else {
        throw Exception('Invalid response format: Movie repo IMPL');
      }
    } on DioException catch (dioException) {
      return left(ServerFailure.DioException(dioException));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getUpcomingMovies() async {
    try {
      final response = await apiService.get(
        url: '${dotenv.env[kbaseUrl]}upcoming?api_key=${dotenv.env[kapiKey]}',
      );

      if (response.containsKey('results')) {
        final List<MovieModel> movies = (response['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return right(movies);
      } else {
        throw Exception('Invalid response format: Movie repo IMPL');
      }
    } on DioException catch (dioException) {
      print(dioException);
      return left(ServerFailure.DioException(dioException));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies() async {
    try {
      final response = await apiService.get(
        url: '${dotenv.env[kbaseUrl]}top_rated?api_key=${dotenv.env[kapiKey]}',
      );

      if (response.containsKey('results')) {
        final List<MovieModel> movies = (response['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return right(movies);
      } else {
        throw Exception('Invalid response format: Movie repo IMPL');
      }
    } on DioException catch (dioException) {
      return left(ServerFailure.DioException(dioException));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getNowPlayingMovies() async {
    try {
      final response = await apiService.get(
        url:
            '${dotenv.env[kbaseUrl]}now_playing?api_key=${dotenv.env[kapiKey]}',
      );

      if (response.containsKey('results')) {
        final List<MovieModel> movies = (response['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return right(movies);
      } else {
        throw Exception('Invalid response format: Movie repo IMPL');
      }
    } on DioException catch (dioException) {
      return left(ServerFailure.DioException(dioException));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MoviePageModel>> getMovieDetails(int movieId) async {
    try {
      final response = await apiService.get(
        url: '${dotenv.env[kbaseUrl]}$movieId?api_key=${dotenv.env[kapiKey]}',
      );

      final MoviePageModel movieDtails = MoviePageModel.fromJson(response);

      return right(movieDtails);
    } on DioException catch (dioException) {
      return left(ServerFailure.DioException(dioException));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


 @override
 Future<Either<Failure, List<MovieModel>>> getSimilerMovies(int movieId) async {
    try {
      final response = await apiService.get(
        url: '${dotenv.env[kbaseUrl]}$movieId/similar?api_key=${dotenv.env[kapiKey]}',
      );
      
       if (response.containsKey('results')) {
        final List<MovieModel> movies = (response['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return right(movies);
      } else {
        throw Exception('Invalid response format: Movie repo IMPL');
      }
    } on DioException catch (dioException) {
      return left(ServerFailure.DioException(dioException));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<MovieModel>>> getSearchedMovies({
    required String moviename ,
     required int page ,
      required String language , 
      required bool adult , 
       }) async{
    try {
      final response = await apiService.get(
        url: '${dotenv.env[kbasesearchURL]}include_adult=$adult&language=$language&page=$page&query=$moviename&api_key=${dotenv.env[kapiKey]}',
      );
      
       if (response.containsKey('results')) {
        final List<MovieModel> movies = (response['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return right(movies);
      } else {
        throw Exception('Invalid response format: Movie repo IMPL');
      }
    } on DioException catch (dioException) {
      return left(ServerFailure.DioException(dioException));
    } catch (e) {
      
      return left(ServerFailure(e.toString()));
    }
  }

}
