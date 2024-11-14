import 'package:get_it/get_it.dart';
import 'package:sahra/data/sources/API/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late HTTPService _http;

  MovieService() {
    _http = getIt.get<HTTPService>();
  }
}
