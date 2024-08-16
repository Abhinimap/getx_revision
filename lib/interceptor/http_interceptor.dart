import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getx_revision/constants/app.dart';
import 'package:getx_revision/constants/exception.dart';
import 'package:getx_revision/models/article_model.dart';
import 'package:getx_revision/result.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AppHttpInterceptor extends InterceptorContract {
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) {
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    if (response.statusCode >= 300) {
      debugPrint(
          "Error caught while making Api Request : ${response is Response ? response.body : ''}");
    }

    return response;
  }
}

class AppRetryPolicy extends RetryPolicy {
  @override
  FutureOr<bool> shouldAttemptRetryOnException(
      Exception reason, BaseRequest request) {
    if (reason.runtimeType == SocketException ||
        reason.runtimeType == FormatException) {
      return true;
    } else {
      return false;
    }
  }

  @override
  FutureOr<bool> shouldAttemptRetryOnResponse(BaseResponse response) {
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Duration delayRetryAttemptOnException({required int retryAttempt}) {
    return const Duration(seconds: 2);
  }

  @override
  int get maxRetryAttempts => 5;
}

class AppHttpClient {
  AppHttpClient._internal();

  static AppHttpClient? _appHttpClient;

  factory AppHttpClient() {
    if (_appHttpClient != null) {
      return _appHttpClient!;
    } else {
      _appHttpClient = AppHttpClient._internal();
    }
    return _appHttpClient!;
  }
  static final InterceptedClient client = InterceptedClient.build(
    interceptors: [AppHttpInterceptor()],
    requestTimeout: const Duration(seconds: 3),
    retryPolicy: AppRetryPolicy(),
  );

  Future<Result<dynamic, Exception>> get(
      {required String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    try {
      final response = await client.get(
          Uri.parse(
            AppConstants.baseUrl + endpoint,
          ),
          headers: headers,
          params: params);
      switch (response.statusCode) {
        case >= 200 && < 300:
          final responseBody = json.decode(response.body);
          if (params?.values.contains('bitcoin') ?? false) {
            return Success((responseBody['articles'] as List<dynamic>)
                .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
                .toList(growable: false));
          } else if (params?.values.contains('apple') ?? false) {
            return Success((responseBody['articles'] as List<dynamic>)
                .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
                .toList(growable: false));
          } else if (params?.values.contains('techcrunch') ?? false) {
            return Success((responseBody['articles'] as List<dynamic>)
                .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
                .toList(growable: false));
          } else {
            return Failure(AppException(message: 'Something Went Wrong...'));
          }

        case >= 300:
          return AppEceptionMapper()
              .mapStatusCodeToFailure(response.statusCode, response);
        default:
          return Failure(AppException(message: 'Something Went Wrong...'));
      }
    } catch (e) {
      debugPrint('error : $e');
      return Failure(
          AppException(message: 'Something Went Wrong: Error Cached'));
    }
  }

  Future<Result<dynamic, Exception>> post(
      {required String endpoint,
      Map<String, String>? headers,
      Object? requestBody,
      Map<String, dynamic>? params}) async {
    final response = await client.post(
        Uri.parse(
          AppConstants.baseUrl + endpoint,
        ),
        body: json.encode(requestBody),
        headers: headers,
        params: params);
    switch (response.statusCode) {
      case >= 200 && < 300:
        final responseBody = json.decode(response.body);
        return const Success('');

      case > 300:
        return AppEceptionMapper()
            .mapStatusCodeToFailure(response.statusCode, response);

      default:
        return Failure(AppException(message: 'Something Went Wrong'));
    }
  }
}
