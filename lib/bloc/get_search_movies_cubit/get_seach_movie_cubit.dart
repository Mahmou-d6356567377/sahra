import 'package:bloc/bloc.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';

part 'get_seach_movie_state.dart';

class GetSeachMovieCubit extends Cubit<GetSeachMovieState> {
  GetSeachMovieCubit(this.movieRepo) : super(GetSeachMovieInitial());
  MovieRepo movieRepo;

  Future<void> fetchSearchMovies({
    required String moviename,
    required int page,
    required String language,
    required bool adult,
  }) async {
    emit(GetSeachMovieLoading());
    var result = await movieRepo.getSearchedMovies(
        moviename: moviename, page: page, language: language, adult: adult);
    result.fold((failure) {
      emit(GetSeachMovieFailure(errmsg: failure.errorMSG));
    }, (movies) {
      emit(GetSeachMovieSuccess(movies: movies));
    });
  }
}
