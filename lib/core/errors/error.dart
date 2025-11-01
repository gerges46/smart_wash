import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
  factory ServerFailure.fromDioErorr(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("connection time out with api server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("send time out with api server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("receive time out with api server");
      case DioExceptionType.badCertificate:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      /*            if (dioException.response != null) {
          return ServerFailure.fromResponse(
              dioException.response!.statusCode ?? 0, dioException.response!.data);
        } */
      case DioExceptionType.badResponse:
        return ServerFailure("your request is bad response ");
      case DioExceptionType.cancel:
        return ServerFailure("request server is canceled ");
      case DioExceptionType.connectionError:
        return ServerFailure("there is a connection error");
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure("No Internet Connection");
        } else {
          return ServerFailure("An unknown error occurred");
        }
      }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('not found');
    } else if (statusCode == 500) {
      return ServerFailure("Internal Server Failure , try again later");
    } else {
      return ServerFailure("Opps there was an error!");
    }
  }
}