import 'package:dio/dio.dart';
import 'package:getx_revision/bindings/apple_binding.dart';
import 'package:getx_revision/result.dart';
import 'package:http/http.dart' as http;

class AppException implements Exception {
  String message;
  AppException({this.message = ''});
}

/// use Exception when statusCode is 400
class AppBadRequestException extends AppException {
  AppBadRequestException([String mesg = '']) : super(message: mesg);
}

/// use Exception when statusCode is 401
class AppUnAuthrizedException extends AppException {
  AppUnAuthrizedException([String mesg = '']) : super(message: mesg);
}

/// use Exception when statusCode is 403
class AppForbiddenException extends AppException {
  AppForbiddenException([String mesg = '']) : super(message: mesg);
}

/// use Exception when statusCode is 500
class AppInternalServerException extends AppException {
  AppInternalServerException([String mesg = '']) : super(message: mesg);
}

/// use Exception when statusCode is 503
class AppServerUnavailableException extends AppException {
  AppServerUnavailableException([String mesg = '']) : super(message: mesg);
}

/// use Exception when statusCode is 502
class AppBadGetwayException extends AppException {
  AppBadGetwayException([String mesg = '']) : super(message: mesg);
}

/// use Exception when statusCode is >=400 && <500
class AppClientException extends AppException {
  AppClientException([String mesg = '']) : super(message: mesg);
}

/// use Exception when statusCode is >=500
class AppServerException extends AppException {
  AppServerException([String mesg = '']) : super(message: mesg);
}

class AppEceptionMapper {
  Failure mapStatusCodeToFailure(int statusCode, http.Response response) {
    switch (statusCode) {
      case > 300 && < 400:
        return Failure(
            AppException(message: 'Something Went Wrong : >300 & <400'));
      case >= 400 && < 500:
        switch (statusCode) {
          case 400:
            return Failure(
                AppBadRequestException('Bad Request :${response.body} '));

          case 401:
            return Failure(AppUnAuthrizedException());
          case 403:
            return Failure(AppForbiddenException());
        }
        return Failure(
            AppException(message: 'Something Went Wrong : >400 & <500'));

      case >= 500:
        switch (statusCode) {
          case 500:
            return Failure(
                AppInternalServerException('Bad Request :${response.body} '));
          case 502:
            return Failure(AppBadGetwayException());
          case 503:
            return Failure(AppServerUnavailableException());
        }
        return Failure(AppServerException());
      default:
        return Failure(AppException());
    }
  }
}
