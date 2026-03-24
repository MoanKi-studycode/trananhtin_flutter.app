import 'package:get/get.dart';

class ControllerCounter65HTTT extends GetxController {
  final counter = 0.obs;

  static ControllerCounter65HTTT get instance => Get.find<ControllerCounter65HTTT>();
  void increment(){
    counter.value++;
  }
}

class ControllerCounter65HTTT2 extends GetxController{
  int counter = 0;
  int sum = 0;

  static ControllerCounter65HTTT2 get instance => Get.find<ControllerCounter65HTTT2>();
  void increment(){
    counter ++;
    sum = counter + 5;
    update(["01","02"]);
  }
}

class BindingsController65HTTT extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerCounter65HTTT());
    Get.lazyPut(() => ControllerCounter65HTTT2());
  }
}