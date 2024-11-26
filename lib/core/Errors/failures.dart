import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMSG;

  Failure(this.errorMSG);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMSG);

  factory ServerFailure.DioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connection Time out with Api Server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('send Time out with Api Server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receive Time out with Api Server');
      case DioExceptionType.badCertificate:
        return ServerFailure('connection Time out with Api Server');
      case DioExceptionType.badResponse:
        return ServerFailure('Error in reponse process');
      case DioExceptionType.cancel:
        return ServerFailure('the process has canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('No internet ');
      case DioExceptionType.unknown:
        return ServerFailure('unknown Error , try again!   ');
      default:
        return ServerFailure('An unexpected error occurred');
    }
  }
}
