import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahra/data/models/main_page_model/main_page_model.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/sources/movie/movie_service.dart';
import 'package:get_it/get_it.dart';

class MainPageController extends StateNotifier<MainPageModel> {
  final MovieServiceRepo _movieServiceRepo;

  MainPageController(this._movieServiceRepo)
      : super(MainPageModel.initial());

  Future<void> getMovies() async {
    try {
      final movies = await _movieServiceRepo.getPopulerMovies(page: state.page);

      state = state.copyWith(
        movies: [...state.movies, ...movies],
        page: state.page + 1,
      );
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }
}
