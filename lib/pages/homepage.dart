import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/home_page_controller.dart';
import '../infrastructures/routes/page_constants.dart';

class Dhashoard extends GetView<DashboardScreenController> {
  const Dhashoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                controller.errorMessage.value,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchDashboardData,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8EEF8),
                  Color(0xFFF7F9FD),
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: SafeArea(
                top: false,
                bottom: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    _buildKpiStrip(),
                    SizedBox(height: 18.h),
                    _buildSectionTitle("Dashboard Overview"),
                    SizedBox(height: 12.h),
                    _buildDashboardGrid(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: const Color(0xFF2C4A6B),
      toolbarHeight: 60.h,
      leadingWidth: 56.w,

      // LEFT SIDE (Logout)
      leading: Padding(
        padding: EdgeInsets.only(left: 12.w, top: 6.h, bottom: 6.h),
        child: Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              final shouldLogout = await _showLogoutDialog(context);
              if (shouldLogout == true) {
                controller.logoutUser();
              }
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.red,
              size: 22,
            ),
          ),
        ),
      ),

      // CENTER TITLE
      centerTitle: true,
      title: Obx(
            () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.schoolName.value.isEmpty
                  ? "School Dashboard"
                  : controller.schoolName.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Session ${controller.session.value}",
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),

      // RIGHT SIDE (Notification)
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.toNamed(RouteName.login_screen);
              },
              icon: const Icon(
                Icons.notifications_active,
                color: Color(0xFF2C4A6B),
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool?> _showLogoutDialog(BuildContext context) {
    return Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Get.back(result: true),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1F2937),
      ),
    );
  }

  Widget _buildKpiStrip() {
    return Obx(() {
      final previewItems = controller.filteredList.take(4).toList();
      if (previewItems.isEmpty) {
        return const SizedBox.shrink();
      }

      return SizedBox(
        height: 96.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: previewItems.length,
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (context, index) {
            final item = previewItems[index];
            return Container(
              width: 150.w,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: item.gradientColors ??
                      [
                        item.color.withOpacity(0.9),
                        item.color,
                      ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: item.color.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(item.image, color: Colors.white, size: 20.sp),
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white.withOpacity(0.90),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _formatCount(item.count),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildDashboardGrid() {
    return Obx(() {
      if (controller.filteredList.isEmpty) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 30.h),
          alignment: Alignment.center,
          child: Text(
            "No dashboard items found",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }

      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.filteredList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemBuilder: (context, index) {
          final item = controller.filteredList[index];

          return InkWell(
            onTap: () => controller.onSelectedBottom(index),
            borderRadius: BorderRadius.circular(18.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.color.withOpacity(0.13),
                    Colors.white,
                  ],
                ),
                border: Border.all(
                  color: item.color.withOpacity(0.18),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: item.color.withOpacity(0.09),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 46.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: item.gradientColors ??
                            [
                              item.color.withOpacity(0.9),
                              item.color,
                            ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: item.color.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      item.image,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D2433),
                        height: 1.25,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _formatCount(item.count),
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: const Color(0xFF0F172A),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  String _formatCount(String count) {
    final value = int.tryParse(count) ?? 0;
    final text = value.toString();
    return text.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
    );
  }
}