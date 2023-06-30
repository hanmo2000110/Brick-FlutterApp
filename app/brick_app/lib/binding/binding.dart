import 'package:get/get.dart';

import '../controller/cameraController.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CamController());
  }
}
