import 'package:bloc/bloc.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';

part 'get_play_iing_now_state.dart';

class GetPlayIingNowCubit extends Cubit<GetPlayIingNowState> {
  GetPlayIingNowCubit(this.movieRepo) : super(GetPlayIingNowInitial());

  MovieRepo movieRepo;

  Future<void> fetchPlayingNowMovies() async {
    emit(GetPlayIingNowLoading());
    var result = await movieRepo.getNowPlayingMovies();
    result.fold((failure) {
      emit(GetPlayIingNowFailure(errmsg: failure.errorMSG));
    }, (movies) {
      emit(GetPlayIingNowSuccess(movies: movies));
    });
  }
}
