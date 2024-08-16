import 'package:dio/dio.dart';

class AppDioClient {
AppDioClient._();

static final _dio = Dio(
BaseOptions()
);
}