part of 'get_seach_movie_cubit.dart';

abstract class GetSeachMovieState {}

class GetSeachMovieInitial extends GetSeachMovieState {}
class GetSeachMovieLoading extends GetSeachMovieState {}
class GetSeachMovieSuccess extends GetSeachMovieState {
    final List<MovieModel> movies;

  GetSeachMovieSuccess({required this.movies});

}
class GetSeachMovieFailure extends GetSeachMovieState {
  final String errmsg;

  GetSeachMovieFailure({required this.errmsg});
}
