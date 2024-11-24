import 'package:sahra/data/models/category_model/search_category.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';

class MainPageModel {
  final List<MovieModel> movies;
  final int page;
  final String searchCategory;
  final String searchText;

  MainPageModel({
    required this.movies,
    required this.page,
    required this.searchCategory,
    required this.searchText,
  });

  factory MainPageModel.initial() {
    return MainPageModel(
      movies: [],
      page: 1,
      searchCategory: SearchCategory.populer,
      searchText: '',
    );
  }

  MainPageModel copyWith({
    List<MovieModel>? movies,
    int? page,
    String? searchCategory,
    String? searchText,
  }) {
    return MainPageModel(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
