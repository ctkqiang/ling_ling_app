import 'package:get/get.dart';
import 'package:ling_ling_app/controller/dialer_controller.dart';

class LingLingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DialerController.create());
  }
}
