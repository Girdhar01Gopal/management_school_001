import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/home_page_controller.dart';

class Dhashoard extends GetView<DashboardScreenController> {
  const Dhashoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5F6368),
        elevation: 0,
        toolbarHeight: 75.h,
        centerTitle: true,
        automaticallyImplyLeading: false,

        /// LEFT SIDE 3 DOT MENU
        leading: PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
          onSelected: (value) async {
            if (value == "logout") {
              final shouldLogout = await _showLogoutDialog(context);
              if (shouldLogout == true) {
                controller.logoutUser();
              }
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<String>(
              value: "logout",
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 10),
                  Text("Logout"),
                ],
              ),
            ),
          ],
        ),

        title: Obx(() {
          final logoUrl = controller.schoolLogoUrl;

          if (logoUrl.isNotEmpty) {
            return SizedBox(
              height: 50.h,
              width: 150.w,
              child: CachedNetworkImage(
                imageUrl: logoUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                controller.schoolName.value.isNotEmpty
                    ? Text(
                  controller.schoolName.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            );
          }

          return controller.schoolName.value.isNotEmpty
              ? Text(
            controller.schoolName.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )
              : const SizedBox.shrink();
        }),

        /// RIGHT SIDE NOTIFICATION ICON
        actions: [
          IconButton(
            tooltip: "Notifications",
            icon: const Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
            onPressed: () {
              Get.snackbar(
                "Notification",
                "No new notifications",
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(12),
                duration: const Duration(seconds: 2),
              );
            },
          ),
        ],
      ),
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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopInfoCard(),
                SizedBox(height: 20.h),
                _buildSectionTitle("Quick Access"),
                SizedBox(height: 12.h),
                _buildDashboardGrid(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
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
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTopInfoCard() {
    return Obx(
          () => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5F6368),
              Color(0xFF7A7F85),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.schoolName.value.isEmpty
                  ? "School Management"
                  : controller.schoolName.value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _infoTile(
                    label: "Session",
                    value: controller.session.value.isEmpty
                        ? "-"
                        : controller.session.value,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _infoTile(
                    label: "School ID",
                    value: controller.schoolId.value.isEmpty
                        ? "-"
                        : controller.schoolId.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: _infoTile(
                    label: "Username",
                    value: controller.userName.value.isEmpty
                        ? "-"
                        : controller.userName.value,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _infoTile(
                    label: "Sibling Count",
                    value: controller.siblingCount.value.isEmpty
                        ? "0"
                        : controller.siblingCount.value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
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
          childAspectRatio: 1.8,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 14.h,
        ),
        itemBuilder: (context, index) {
          final item = controller.filteredList[index];

          return InkWell(
            onTap: () => controller.onSelectedBottom(index),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.color.withOpacity(0.16),
                    Colors.white,
                  ],
                ),
                border: Border.all(
                  color: item.color.withOpacity(0.12),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: item.color.withOpacity(0.10),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
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
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      item.image,
                      size: 28.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          item.count.isEmpty ? "0" : item.count,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
}