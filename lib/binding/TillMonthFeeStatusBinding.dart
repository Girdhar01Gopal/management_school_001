import 'package:get/get.dart';
import '../controller/SessionMonthWiseFeecontroller.dart';
import '../controller/Till month fee status controller.dart';

class TillMonthFeeStatusScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TillMonthFeeStatusController>(
          () => TillMonthFeeStatusController(),
    );
  }
}