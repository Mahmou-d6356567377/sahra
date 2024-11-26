  import 'package:get_it/get_it.dart';
  import 'package:sahra/data/repos/movie_repo/movie_repo_IMPL.dart';
  import 'package:sahra/data/sources/API/api_service.dart';

  final getIt = GetIt.instance;

  void serviceLocator() {
    getIt.registerSingleton<ApiService>(ApiService());
    getIt.registerSingleton<MovieRepoImpl>(
        MovieRepoImpl(apiService: getIt.get<ApiService>()));
  }
