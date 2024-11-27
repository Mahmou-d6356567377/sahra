import 'package:bloc/bloc.dart';
import 'package:sahra/data/models/movie_model/movie_model.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo.dart';

part 'get_up_coming_cubit_state.dart';

class GetUpComingCubitCubit extends Cubit<GetUpComingCubitState> {
  GetUpComingCubitCubit(this.movieRepo) : super(GetUpComingCubitInitial());
  MovieRepo movieRepo;

  Future<void> fetchUpComingMovies() async {
    emit(GetUpComingCubitLoading());
    var result = await movieRepo.getUpcomingMovies();
    result.fold((failure) {
      emit(GetUpComingCubitFailure(failure.errorMSG));
    }, (movies) {
      emit(GetUpComingCubitSuccess(upcomingMovies: movies));
    });
  }
}
