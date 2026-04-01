import 'package:get/get.dart';
import '../controller/notification_controller.dart';

class NotificationDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationDashboardController>(
          () => NotificationDashboardController(),
    );
  }
}