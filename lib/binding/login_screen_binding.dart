import 'package:get/get.dart';


import '../controller/login_page_controller.dart';
import '../login_view_model.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LogInPageController(),
    );
    Get.lazyPut(
      () => LoginViewModel(),
    );
  }
}
