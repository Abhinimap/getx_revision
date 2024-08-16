import 'package:get/get.dart';
import 'package:getx_revision/controllers/api_controller.dart';
import 'package:getx_revision/controllers/tech_crunch_controller.dart';

class TechCrunchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>TechCrunchController());
  }
}