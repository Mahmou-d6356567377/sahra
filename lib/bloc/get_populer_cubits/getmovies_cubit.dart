import 'package:bloc/bloc.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';

part 'getmovies_state.dart';

class GetmoviesCubit extends Cubit<GetmoviesState> {
  MovieRepo movieRepo;
  GetmoviesCubit(
    this.movieRepo,
  ) : super(GetmoviesInitial());
  Future<void> fetchMovies(int page) async {
    emit(GetmoviesLoading());
    var result = await movieRepo.getPopulerMovies(page: page);
    result.fold((failure) {
      emit(GetmoviesFailure(errmsg: failure.errorMSG));
    }, (movies) {
      emit(GetmoviesSuccess(movies: movies));
    });
  }
}
