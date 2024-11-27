part of 'get_top_rated_cubit_cubit.dart';

@immutable
abstract class GetTopRatedCubitState {}

class GetTopRatedCubitInitial extends GetTopRatedCubitState {}

class GetTopRatedCubitLoading extends GetTopRatedCubitState {}

class GetTopRatedCubitSuccess extends GetTopRatedCubitState {
  final List<MovieModel> movies;

  GetTopRatedCubitSuccess({required this.movies});
}

class GetTopRatedCubitFailure extends GetTopRatedCubitState {
  final String errmsg;

  GetTopRatedCubitFailure({required this.errmsg});
}
