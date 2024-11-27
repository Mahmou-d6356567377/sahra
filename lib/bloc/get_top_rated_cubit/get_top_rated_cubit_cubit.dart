import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';

part 'get_top_rated_cubit_state.dart';

class GetTopRatedCubitCubit extends Cubit<GetTopRatedCubitState> {
  GetTopRatedCubitCubit(this.movieRepo) : super(GetTopRatedCubitInitial());
  MovieRepo movieRepo;

  Future<void> fetchTopRatedMovies() async {
    emit(GetTopRatedCubitLoading());
    var result = await movieRepo.getTopRatedMovies();
    result.fold((failure) {
      emit(GetTopRatedCubitFailure(errmsg: failure.errorMSG));
    }, (movies) {
      emit(GetTopRatedCubitSuccess(movies: movies));
    });
  }
}
