import 'package:get/get.dart';
import '../controller/holiday_controller.dart';

class HolidayDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HolidayDashboardController>(
          () => HolidayDashboardController(),
    );
  }
}