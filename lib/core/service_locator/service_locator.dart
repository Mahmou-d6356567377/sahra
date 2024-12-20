import 'package:get_it/get_it.dart';
import 'package:sahra/data/repos/movie_repo/movie_repo_IMPL.dart';
import 'package:sahra/data/sources/API/api_service.dart';

final getIt = GetIt.instance;

void serviceLocator() {
  // Register ApiService as a lazy singleton
  getIt.registerLazySingleton(() => ApiService());

  // Register MovieRepoImpl as a lazy singleton
  getIt.registerLazySingleton(() => MovieRepoImpl(apiService: getIt.get<ApiService>()));
}
