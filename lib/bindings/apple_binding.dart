import 'package:get/get.dart';
import 'package:getx_revision/controllers/apple_controller.dart';

class AppleControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>AppleController());
  }
}