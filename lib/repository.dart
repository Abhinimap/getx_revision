import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:getx_revision/constants/exception.dart';
import 'package:getx_revision/models/article_model.dart';
import 'package:getx_revision/result.dart';
import 'package:http/http.dart' as http;

class ApiServiceRepository {
  String get _apiKey => dotenv.get('NEWS_API_KEY');
  static const String _apiUrl = "https://newsapi.org/v2/everything";
  Future<Result<List<ArticleModel>, AppException>> getAllBitcoinArticles() async {
    try {
      final url = Uri(
          scheme: 'https',
          host: 'newsapi.org',path: '/v2/everything', queryParameters: {
        'apiKey': _apiKey,
        'q':'bitcoin'
      });
      print(url);
      final http.Response response =
          await http.get(url);
      print("Response of get ALl Articles  :${response.body}");
      switch (response.statusCode) {
        case 200:
          {
            final decodedResponse = await json.decode(response.body) as Map;
            final articles =( decodedResponse['articles'] as List<dynamic>)
                .map((e) => ArticleModel.fromJson(e))
                .toList() ;
            return Success<List<ArticleModel>, AppException>(articles);
          }

        case 404:
          {
            return Failure(AppException(message:'Not Found'));
          }
        default:
          return Failure(
              AppException(message:'Unable to fetch Data : ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('Error occured while fetching data:$e');
      return Failure(AppException(message:'Error : $e'));
    }
  }


  Future<Result<List<ArticleModel>, AppException>> getAllApppleArticles() async {
    try {
      final url = Uri(
          scheme: 'https',
          host: 'newsapi.org',path: '/v2/everything', queryParameters: {
        'apiKey': _apiKey,
        'q':'apple'
      });
      print(url);
      final http.Response response =
      await http.get(url);
      print("Response of get ALl apple Articles  :${response.body}");
      switch (response.statusCode) {
        case 200:
          {
            final decodedResponse = await json.decode(response.body) as Map;
            final articles =( decodedResponse['articles'] as List<dynamic>)
                .map((e) => ArticleModel.fromJson(e))
                .toList() ;
            return Success<List<ArticleModel>, AppException>(articles);
          }

        case 404:
          {
            return Failure(AppException(message:'Not Found'));
          }
        default:
          return Failure(
              AppException(message:'Unable to fetch Data : ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('Error occured while fetching apple data:$e');
      return Failure(AppException(message:'Error : $e'));
    }
  }



  Future<Result<List<ArticleModel>, AppException>> getAllTechCrunchArticles() async {
    try {
      final url = Uri(
          scheme: 'https',
          host: 'newsapi.org',path: '/v2/everything', queryParameters: {
        'apiKey': _apiKey,
        'domains':'techcrunch.com,thenextweb.com'
      });
      print(url);
      final http.Response response =
      await http.get(url);
      print("Response of get ALl techcrunch Articles  :${response.body}");
      switch (response.statusCode) {
        case 200:
          {
            final decodedResponse = await json.decode(response.body) as Map;
            final articles =( decodedResponse['articles'] as List<dynamic>)
                .map((e) => ArticleModel.fromJson(e))
                .toList() ;
            return Success<List<ArticleModel>, AppException>(articles);
          }

        case 404:
          {
            return Failure(AppException(message:'Not Found'));
          }
        default:
          return Failure(
              AppException(message:'Unable to fetch Data : ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('Error occured while fetching techcrunch data:$e');
      return Failure(AppException(message:'Error : $e'));
    }
  }
}
