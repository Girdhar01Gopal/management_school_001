import 'package:get/get.dart';
import '../controller/SessionMonthWiseFeecontroller.dart';

class SessionMonthWiseFeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionMonthWiseFeeController>(
          () => SessionMonthWiseFeeController(),
    );
  }
}