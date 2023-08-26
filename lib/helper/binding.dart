import 'package:get/get.dart';
import '../controller/control_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControlController>(() => ControlController());
  }
}