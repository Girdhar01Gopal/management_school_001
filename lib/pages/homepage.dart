import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/home_page_controller.dart';
import '../wigets.dart';

class Dhashoard extends GetView<DashboardScreenController> {
  const Dhashoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(),
     // drawer: AppDrawer(),// Removed FAB Chat icon and "Say, Hi Edubloom!" text
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5F6368), // Modern cool gray color
        elevation: 0,
        toolbarHeight: 75.h,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: "Change Password",
            icon: const Icon(Icons.password, color: Colors.white),
            onPressed: () {
              // Get.toNamed(RouteName.changepassword);
            },
          ),
        ],
        title: Text(
          "School Management",
          style: TextStyle(
            fontSize: 22.sp, // Increased text size
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildStatsGrid(),
            SizedBox(height: 14.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 400.h, // Limit the max height to avoid overflow
              ),
              child: _buildDashboardGrid(),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _statCard(
            title: "Total Students",
            icon: Icons.school_rounded,
            color: const Color(0xFF6F42C1),
            onTap: () {
              // Get.toNamed(RouteName.totalstudent);
            },
            valueWidget: Text(
              "${controller.totalStudentCount.value}",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF6F42C1),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _statCard(
            title: "Fees Due In ${DateFormat('MMM').format(DateTime.now())}",
            icon: Icons.currency_rupee_rounded,
            color: const Color(0xFFE53935),
            valueWidget: Text(
              "₹ ${controller.totaldueamount.value.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFE53935),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget valueWidget,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xFFF8FAFC),
            ],
          ),
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.12),
              ),
              child: Icon(
                icon,
                size: 24.sp,
                color: color,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            SizedBox(height: 0.h),
            valueWidget,
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardGrid() {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 64.h,
                  width: 64.w,
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
                    size: 30.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "${item.count}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}