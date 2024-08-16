import 'package:get/get.dart';
import 'package:getx_revision/models/article_model.dart';
import 'package:getx_revision/repository.dart';
import 'package:getx_revision/result.dart';
class NewsApiController extends GetxController{

  var  data=<ArticleModel>[].obs;
  var isFetching = false.obs;

  var errorMessage=''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void callApi()async{
    isFetching.value=true;
    errorMessage.value='';
    final response = await ApiServiceRepository().getAllBitcoinArticles();
    isFetching.value=false;
    switch(response){
      case Success(value: final articles):
        data.value=articles;
        break;
      case Failure<List<ArticleModel>, Exception>(exception:final e):
        data.value=[];
        print("ERror printing from controller :${e}");
        errorMessage.value=e.toString();
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}