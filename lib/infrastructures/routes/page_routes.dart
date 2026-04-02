import 'package:get/get.dart';
import 'package:management_school/infrastructures/routes/page_constants.dart';

import '../../binding/dashboard_screen_binding.dart';
import '../../binding/holiday_binding.dart';
import '../../binding/login_screen_binding.dart';
import '../../binding/notification_binding.dart';
import '../../binding/splash_screen_bindings.dart';
import '../../pages/holiday_screen.dart';
import '../../pages/homepage.dart';
import '../../pages/logInpage.dart';
import '../../pages/notification_screen.dart';
import '../../pages/splashscreen.dart';



class AppRoutes {
  static appRoutes() => [

 GetPage(
          name: RouteName.splash_screen,
          page: () => SplashScreen(),
          transition: Transition.rightToLeft,
          binding: SpalshScreenBindings(),
        ),
        GetPage(
          name: RouteName.login_screen,
          page: () => LoginScreen(),
          transition: Transition.rightToLeft,
          binding: LoginScreenBinding(),
        ),
    GetPage(
      name: RouteName.notification_dashboard_screen,
      page: () =>  NotificationDashboardScreen(),
      transition: Transition.rightToLeft,
      binding: NotificationDashboardBinding(),
    ),

    GetPage(
      name: RouteName.holiday_dashboard_screen,
      page: () =>  HolidayDashboardScreen(),
      transition: Transition.rightToLeft,
      binding: HolidayDashboardBinding(),
    ),

    GetPage(
      name: RouteName.dashboard_screen,
      page: () => Dhashoard(),
      transition: Transition.rightToLeft,
      binding: DashboardScreenBinding(),
    ),

  ];
}