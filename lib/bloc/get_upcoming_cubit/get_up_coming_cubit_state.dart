part of 'get_up_coming_cubit_cubit.dart';

abstract class GetUpComingCubitState {}

class GetUpComingCubitInitial extends GetUpComingCubitState {}

class GetUpComingCubitLoading extends GetUpComingCubitState {}

class GetUpComingCubitFailure extends GetUpComingCubitState {
  final String errMsg;

  GetUpComingCubitFailure(this.errMsg);
}

class GetUpComingCubitSuccess extends GetUpComingCubitState {
  final List<MovieModel> upcomingMovies;

  GetUpComingCubitSuccess({required this.upcomingMovies});
}
