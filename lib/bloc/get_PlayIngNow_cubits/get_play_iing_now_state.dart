part of 'get_play_iing_now_cubit.dart';

abstract class GetPlayIingNowState {}

class GetPlayIingNowInitial extends GetPlayIingNowState {}

class GetPlayIingNowLoading extends GetPlayIingNowState {}

class GetPlayIingNowSuccess extends GetPlayIingNowState {
  final List<MovieModel> movies;

  GetPlayIingNowSuccess({required this.movies});
}

class GetPlayIingNowFailure extends GetPlayIingNowState {
  final String errmsg;

  GetPlayIingNowFailure({required this.errmsg});
}
