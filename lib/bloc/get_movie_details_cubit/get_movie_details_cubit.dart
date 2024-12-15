import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sahra/data/models/movie_page_model/movie_page_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';

part 'get_movie_details_state.dart';

class GetMovieDetailsCubit extends Cubit<GetMovieDetailsState> {
  GetMovieDetailsCubit(this.movieRepo) : super(GetMovieDetailsInitial());
  MovieRepo movieRepo;

  Future<void> fetchTopRatedMovies(int movieId) async {
    emit(GetMovieDetailsLoading());
    var result = await movieRepo.getMovieDetails(movieId);
    result.fold((failure) {
      emit(GetMovieDetailsFailure(errMsg: failure.errorMSG));
    }, (movies) {
      emit(GetMovieDetailsSuccess(movieDetails: movies));
    });
  }
}
