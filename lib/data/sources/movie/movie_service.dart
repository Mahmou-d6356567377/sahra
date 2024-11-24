import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/sources/API/api_service.dart';

class MovieServiceRepo {
  final ApiService apiService;

  MovieServiceRepo({required this.apiService});

  Future<List<MovieModel>> getPopulerMovies({
    required int page,
    String? token,
  }) async {
    try {
      final response = await apiService.get(
        url: '/movie/populer?page=$page',
        token: token,
      );

      if (response.containsKey('results')) {
        final List<MovieModel> movies = (response['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();
        return movies;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }
}
