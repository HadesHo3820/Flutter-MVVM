import 'package:counter/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  sucesss,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaults,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so its error from response of the API
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaults.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.defaults.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.other:
        return DataSource.defaults.getFailure();
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(
            code: ResponseCode.badRequest, message: ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(
            code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(
            code: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(
            code: ResponseCode.notFound, message: ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(
            code: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            code: ResponseCode.connectTimeout,
            message: ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(
            code: ResponseCode.cancel, message: ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(
            code: ResponseCode.sendTimeout,
            message: ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(
            code: ResponseCode.cacheError, message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(
            code: ResponseCode.noInternetConnection,
            message: ResponseMessage.noInternetConnection);
      case DataSource.defaults:
        return Failure(
            code: ResponseCode.defaults, message: ResponseMessage.defaults);
      default:
        return Failure(
            code: ResponseCode.defaults, message: ResponseMessage.defaults);
    }
  }
}

class ResponseCode {
  // API status codes
  static const int sucesss = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorized = 401; // failure user is not authorized
  static const int notFound =
      404; // failure, api url is not correct and not found
  static const int internalServerError =
      500; // failure, crash happened in server side

  // local status code
  static const int defaults = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  static const String sucesss = "success"; // success with data
  static const String noContent =
      "success with no content"; // success with no content
  static const String badRequest =
      "Bad request, try again later"; // failure, api rejected the request
  static const String forbidden =
      "Forbiden request, try again later"; // failure, api rejected the request
  static const String unauthorized =
      "user is unauthorized, try again later"; // failure user is not authorized
  static const String notFound =
      "Url is not found, try again later"; // failure, api url is not correct and not found
  static const String internalServerError =
      "Something went wrong, try again later"; // failure, crash happened in server side

  // local status code
  static const String defaults = "Something went wrong, try again later";
  static const String connectTimeout = "Timeout error, try again later";
  static const String cancel = "Request was cancelled, try again later";
  static const String receiveTimeout = "Timeout error, try again later";
  static const String sendTimeout = "Timeout error, try again later";
  static const String cacheError = "Cache error, try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
}
