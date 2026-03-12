
import 'package:get/get.dart';

import '../controller/connection_controller.dart';
import 'local_storage.dart';



class InitVariables {
  onInit() {
    PrefManager().initlizedStorage();
    Get.put(ConnectionManagerController());
  }
}
