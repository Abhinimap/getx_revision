import 'package:get/get.dart';
import 'package:getx_revision/controllers/api_controller.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(()=>NewsApiController());
  }
}