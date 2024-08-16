import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:getx_revision/interceptor/http_interceptor.dart';
import 'package:getx_revision/models/article_model.dart';
// import 'package:getx_revision/repository.dart';
import 'package:getx_revision/result.dart';

class AppleController extends GetxController{

  @override
  void onReady() {
    super.onReady();
    callApi();
  }
  var  data=<ArticleModel>[].obs;
  var isFetching = false.obs;
  var errorMessage=''.obs;
  String get _apiKey => dotenv.get('NEWS_API_KEY');

  void callApi()async{
    isFetching.value=true;
    errorMessage.value='';

    final response = await AppHttpClient().get(endpoint: 'https://newsapi.org/v2/everything/',params: {
        'apiKey': _apiKey,
        'q':'apple'
      });
isFetching.value=false;
      switch (response) {
        case Success():
          data.value=response.value;
          break;

        case Failure():
          errorMessage.value = response.exception.message;
        default:
          errorMessage.value='Something is not right';
      }
    // final response = await ApiServiceRepository().getAllApppleArticles();
    // isFetching.value=false;
    // switch(response){
    //   case Success(value: final articles):
    //     data.value=articles;
    //     break;
    //   case Failure<List<ArticleModel>, Exception>(exception:final e):
    //     data.value=[];
    //     print("ERror printing from controller :${e}");
    //     errorMessage.value=e.toString();
    //     break;
    // }
  }

}