
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_screen_controller.dart';
import '../infrastructures/constant/image_constant.dart';


class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ImageConstants.background1,
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
            child: Image.asset(
          ImageConstants.logo,
          height: 260,
          width: 200,
        )
            //  CachedNetworkImage(
            //   imageUrl: ImageConstants.logo,
            //   height: 400,
            //   width: 400,
            //   placeholder: (context, url) => const CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => const Icon(
            //     Icons.error,
            //   ),
            // ),
            ),
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Image.asset(
        //         "assets/image/eduagent_logo.png",
        //         height: 400,
        //         width: 400,
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
