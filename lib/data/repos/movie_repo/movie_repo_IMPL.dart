import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sahra/core/Errors/failures.dart';
import 'package:sahra/core/constants/constants_properties.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';
import 'package:sahra/data/sources/API/api_service.dart';
import 'package:dio/dio.dart'; // Import Dio for network-related exceptions

class MovieRepoImpl implements MovieRepo {
  final ApiService apiService;

  MovieRepoImpl({required this.apiService});

  Future<Either<Failure, List<MovieModel>>> getPopulerMovies({
    required int page,
    String? token,
  }) async {
    try {
      final response = await apiService.get(
        url: '${dotenv.env[kbaseUrl]}popular?api_key=${dotenv.env[kapiKey]}&language=en-US&page=$page',
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
