
import 'package:get/get.dart';


class Controller extends GetxController {


  @override
  onInit() {
    super.onInit();

  }


}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
