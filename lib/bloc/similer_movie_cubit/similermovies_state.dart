part of 'similermovies_cubit.dart';

@immutable
abstract class SimilermoviesState {}

class SimilermoviesInitial extends SimilermoviesState {}

class SimilermoviesLoading extends SimilermoviesState {}

class SimilermoviesFailure extends SimilermoviesState {
  final String errmsg;

  SimilermoviesFailure({required this.errmsg});
}

class SimilermoviesSuccess extends SimilermoviesState {
  final List<MovieModel> similerMovies;

  SimilermoviesSuccess({required this.similerMovies});
}
