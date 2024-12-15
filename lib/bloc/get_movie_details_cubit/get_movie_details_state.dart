part of 'get_movie_details_cubit.dart';

@immutable
abstract class GetMovieDetailsState {}

class GetMovieDetailsInitial extends GetMovieDetailsState {}

class GetMovieDetailsLoading extends GetMovieDetailsState {}

class GetMovieDetailsFailure extends GetMovieDetailsState {
  final String errMsg;

  GetMovieDetailsFailure({required this.errMsg});
}

class GetMovieDetailsSuccess extends GetMovieDetailsState {
  final MoviePageModel movieDetails;

  GetMovieDetailsSuccess({required this.movieDetails});
}
