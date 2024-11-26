part of 'getmovies_cubit.dart';


abstract class GetmoviesState {}

class GetmoviesInitial extends GetmoviesState {}

class GetmoviesLoading extends GetmoviesState {}

class GetmoviesSuccess extends GetmoviesState {
  final List<MovieModel> movies;

  GetmoviesSuccess({required this.movies});
}

class GetmoviesFailure extends GetmoviesState {
  final String errmsg;
  
  GetmoviesFailure({required this.errmsg});
}
