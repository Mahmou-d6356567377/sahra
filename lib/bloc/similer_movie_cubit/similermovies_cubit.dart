import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';

part 'similermovies_state.dart';

class SimilermoviesCubit extends Cubit<SimilermoviesState> {
  SimilermoviesCubit(this.movieRepo) : super(SimilermoviesInitial());

  MovieRepo movieRepo;
  Future<void> fetchSimilerMovies(int movieId) async {
    emit(SimilermoviesLoading());
    var result = await movieRepo.getSimilerMovies(movieId);
    result.fold((failure) {
      emit(SimilermoviesFailure(errmsg: failure.errorMSG));
    }, (movies) {
      emit(SimilermoviesSuccess(similerMovies: movies));
    });
  }
}
