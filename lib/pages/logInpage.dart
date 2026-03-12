import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/login_page_controller.dart';
import '../infrastructures/constant/image_constant.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../login_view_model.dart';
import '../repo/app_url.dart';
import '../utils/constans.dart';
import '../utils/custom_text.dart';
import '../utils/utils.dart';


/// Reusable input decoration for a consistent look.
InputDecoration buildInputDecoration({
  required String hint,
  IconData? prefixIcon,
  bool isPassword = false,
  IconButton? suffixIconButton,
}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0.9),
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 12.0.sp,
    ),

    prefixIcon: prefixIcon == null
        ? null 
        : Icon(prefixIcon, color: Colors.grey, size: 20.r),
    suffixIcon: suffixIconButton, // e.g., for password visibility
    contentPadding: EdgeInsets.symmetric(
      vertical: 14.h,
      horizontal: 14.w,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide.none, // Remove default border
    ),
    //dash
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: const BorderSide(
        color: Colors.blueAccent,
        width: 1.5,
      ),
    ),
  );
}

class LoginScreen extends GetView<LogInPageController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Get.find<LoginViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.background1),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 30.h),

              /// --- School Logo or Fallback ---
              Obx(() {
                if (controller.schoolImage.value.isEmpty) {
                  return Image.asset(
                    "assets/image/eduagent_logo.png",
                    height: 280.h,
                    width: 280.w,
                  );
                } else {
                  return Container(
                    height: 100.h,
                    child: CachedNetworkImage(
                      //fit: BoxFit.contain,
                      imageUrl:
                          "${controller.secUrl.value}${AppUrl.imageSecUrl}${controller.schoolImage.value}",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/image/eduagent_logo.png",
                      
                      ),
                    ));}
              }),

              SizedBox(height: 30.h),

              /// --- Form Container ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.0.w,
                      right: 36.0.w,
                      top: 20.0.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// --- SCHOOL ID FIELD ---
                        CustomText(
                          data: "School Id",
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
                        TextFormField(
                          controller: controller.schoolIdController,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                            hint: "Enter School Id",
                            prefixIcon: Icons.school,
                          ),
                          onChanged: (value) {
                            // Save typed School ID to local pref.
                            PrefManager().writeValue(
                              key: PrefConst.SchoolId,
                              value: value.removeAllWhitespace,
                            );
                            // Fetch base URL for the typed school ID
                            controller.getBaseUrl(
                              schoolId: value.removeAllWhitespace,
                            );
                          },
                        ),
                        SizedBox(height: 10.h),

                        /// Decide if the rest of the fields are visible
                        Obx(() {
                          final isSchoolIdRecognized =
                              (controller.schoolDetail.value.applicationURL !=
                                  null);

                          // If not recognized, show a placeholder.
                          if (!isSchoolIdRecognized) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              alignment: Alignment.center,
                              child: const Text(
                                "Please enter a valid School ID to proceed.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }
                          // If recognized, show parent ID + password + sign in button
                          else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// --- PARENT ID FIELD ---
                                CustomText(
                                  data: "Parent Id",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                TextField(
                                  controller: controller.userNamecontroller,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: buildInputDecoration(
                                    hint: "Parent Id",
                                    prefixIcon: Icons.person,
                                  ),
                                  onChanged: (value) {
                                    controller.login.value = value;
                                  },
                                ),
                                SizedBox(height: 10.h),

                                /// --- PASSWORD FIELD ---
                                CustomText(
                                  data: "Password",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                ),
                                Obx(() {
                                  return TextFormField(
                                    controller:
                                        controller.userPasswordcontroller,
                                    keyboardType:
                                        TextInputType.visiblePassword,
                                    obscureText: controller.isObscure.value,
                                    decoration: buildInputDecoration(
                                      hint: "**********",
                                      prefixIcon: Icons.lock,
                                      suffixIconButton: IconButton(
                                        icon: Icon(
                                          controller.isObscure.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed:
                                            controller.togglePasswordVisibility,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      controller.login.value = value;
                                    },
                                  );
                                }),
                                SizedBox(height: 25.h),

                                /// --- SIGN IN BUTTON ---
                                Center(
                                  child: Container(
                                    width: 230.w,
                                    height: 40.h,
                                    decoration:BoxDecoration(
  /// Remove the `color` property if you’re using a gradient
  gradient: LinearGradient(
    colors: [
      kPrimaryColor,      // Start color
      Colors.purple,      // End color (replace with any color you like)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  borderRadius: BorderRadius.circular(6.0.r),
  boxShadow: [
    BoxShadow(
      color: ActiveShadowColor,
      offset: const Offset(0.0, 8.0),
      blurRadius: 8.0.r,
    ),
  ],
)
,
                                    child: InkWell(
                                      onTap: () async {
                                        final parentId = controller
                                            .userNamecontroller
                                            .value
                                            .text
                                            .removeAllWhitespace;
                                        final password = controller
                                            .userPasswordcontroller
                                            .value
                                            .text
                                            .removeAllWhitespace;

                                        if (parentId.isEmpty &&
                                            password.isEmpty) {
                                          ShortMessage.toast(
                                              title: "Empty field");
                                        } else {
                                          final data = {
                                            "UserName": parentId,
                                            "Password": password,
                                          };

                                          // Save credentials to local storage, if needed
                                          await PrefManager().writeValue(
                                            key: PrefConst.UserName,
                                            value: parentId,
                                          );
                                          await PrefManager().writeValue(
                                            key: PrefConst.UserPass,
                                            value: password,
                                          );

                                          // Make the login API call
                                          loginViewModel.loginApi(
                                            data,
                                            controller.baseUrl.value,
                                          );

                                          if (kDebugMode) {
                                            print(
                                                "base url: ${controller.baseUrl.value}");
                                            print("data: $data");
                                            print("API call triggered");
                                          }
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 16.sp,
                                            letterSpacing: 1.0.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
