import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/login_page_controller.dart';
import '../infrastructures/constant/image_constant.dart';
import '../local_storage/local_storage.dart';
import '../local_storage/pref_const.dart';
import '../login_view_model.dart';
import '../repo/app_url.dart';
import '../utils/constans.dart';
import '../utils/custom_text.dart';
import '../utils/utils.dart';

InputDecoration buildInputDecoration({
  required String hint,
  IconData? prefixIcon,
  IconButton? suffixIconButton,
}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0.9),
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 12.sp,
    ),
    prefixIcon: prefixIcon == null
        ? null
        : Icon(
      prefixIcon,
      color: Colors.grey,
      size: 20.r,
    ),
    suffixIcon: suffixIconButton,
    contentPadding: EdgeInsets.symmetric(
      vertical: 14.h,
      horizontal: 14.w,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide.none,
    ),
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
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = Get.find<LoginViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.background1),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20.h),

                /// LOGO
                Obx(() {
                  if (controller.schoolImage.value.isEmpty) {
                    return Image.asset(
                      "assets/image/eduagent_logo.png",
                      height: 220.h,
                      width: 220.w,
                      fit: BoxFit.contain,
                    );
                  }

                  return SizedBox(
                    height: 120.h,
                    child: CachedNetworkImage(
                      imageUrl:
                      "${controller.secUrl.value}${AppUrl.imageSecUrl}${controller.schoolImage.value}",
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/image/eduagent_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }),

                SizedBox(height: 25.h),

                /// FORM BOX
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 20.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          data: "School Id",
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                        SizedBox(height: 8.h),

                        TextFormField(
                          controller: controller.schoolIdController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          decoration: buildInputDecoration(
                            hint: "Enter School Id",
                            prefixIcon: Icons.school,
                          ),
                          onChanged: (value) async {
                            final String cleanValue =
                            value.trim().replaceAll(" ", "");

                            await PrefManager().writeValue(
                              key: PrefConst.SchoolId,
                              value: cleanValue,
                            );

                            if (cleanValue.length == 8) {
                              await controller.getBaseUrl(
                                schoolId: cleanValue,
                              );
                            } else {
                              controller.isGetBaseUrl.value = false;
                              controller.baseUrl.value = "";
                              controller.secUrl.value = "";
                              controller.schoolImage.value = "";
                              controller.schoolname.value = "";
                              controller.schoolphone.value = "";
                              controller.schoolemail.value = "";
                            }
                          },
                        ),

                        SizedBox(height: 16.h),

                        /// SCHOOL NAME SHOW
                        Obx(() {
                          if (controller.schoolname.value.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: EdgeInsets.only(bottom: 14.h),
                            child: Text(
                              controller.schoolname.value,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }),

                        /// USERNAME + PASSWORD ONLY AFTER VALID SCHOOL ID
                        Obx(() {
                          final bool isSchoolValid =
                              controller.isGetBaseUrl.value &&
                                  controller.baseUrl.value.isNotEmpty;

                          if (!isSchoolValid) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 28.h),
                              alignment: Alignment.center,
                              child: Text(
                                "Please enter a valid School ID to proceed.",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: "Username",
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                              SizedBox(height: 8.h),
                              TextFormField(
                                controller: controller.userNamecontroller,
                                keyboardType: TextInputType.text,
                                decoration: buildInputDecoration(
                                  hint: "Enter Username",
                                  prefixIcon: Icons.person,
                                ),
                              ),

                              SizedBox(height: 14.h),

                              CustomText(
                                data: "Password",
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                              ),
                              SizedBox(height: 8.h),

                              Obx(() {
                                return TextFormField(
                                  controller:
                                  controller.userPasswordcontroller,
                                  keyboardType:
                                  TextInputType.visiblePassword,
                                  obscureText: controller.isObscure.value,
                                  decoration: buildInputDecoration(
                                    hint: "Enter Password",
                                    prefixIcon: Icons.lock,
                                    suffixIconButton: IconButton(
                                      onPressed: controller
                                          .togglePasswordVisibility,
                                      icon: Icon(
                                        controller.isObscure.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                  ),
                                );
                              }),

                              SizedBox(height: 24.h),

                              /// LOGIN BUTTON
                              Obx(() {
                                return Center(
                                  child: InkWell(
                                    onTap: controller.isLoading.value
                                        ? null
                                        : () async {
                                      final String schoolId = controller
                                          .schoolIdController.text
                                          .trim()
                                          .replaceAll(" ", "");
                                      final String username = controller
                                          .userNamecontroller.text
                                          .trim();
                                      final String password = controller
                                          .userPasswordcontroller.text
                                          .trim();

                                      if (schoolId.isEmpty) {
                                        ShortMessage.toast(
                                          title: "Enter School ID",
                                        );
                                        return;
                                      }

                                      if (schoolId.length != 8) {
                                        ShortMessage.toast(
                                          title: "Enter valid School ID",
                                        );
                                        return;
                                      }

                                      if (controller.baseUrl.value.isEmpty) {
                                        ShortMessage.toast(
                                          title: "School ID not matched",
                                        );
                                        return;
                                      }

                                      if (username.isEmpty) {
                                        ShortMessage.toast(
                                          title: "Enter Username",
                                        );
                                        return;
                                      }

                                      if (password.isEmpty) {
                                        ShortMessage.toast(
                                          title: "Enter Password",
                                        );
                                        return;
                                      }

                                      await PrefManager().writeValue(
                                        key: PrefConst.UserName,
                                        value: username,
                                      );

                                      await PrefManager().writeValue(
                                        key: PrefConst.UserPass,
                                        value: password,
                                      );

                                      await PrefManager().writeValue(
                                        key: PrefConst.SchoolId,
                                        value: schoolId,
                                      );

                                      final Map<String, dynamic> requestData = {
                                        "Userid": username,
                                        "Password": password,
                                      };

                                      await loginViewModel.loginApi(
                                        requestData,
                                        controller.secUrl.value,
                                      );
                                    },
                                    child: Container(
                                      width: 230.w,
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            kPrimaryColor,
                                            Colors.purple,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ActiveShadowColor,
                                            offset: const Offset(0, 8),
                                            blurRadius: 8.r,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: controller.isLoading.value
                                            ? SizedBox(
                                          height: 20.h,
                                          width: 20.w,
                                          child:
                                          const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                            : Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 16.sp,
                                            letterSpacing: 1.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}