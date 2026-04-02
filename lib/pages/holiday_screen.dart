import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/holiday_controller.dart';

class HolidayDashboardScreen extends GetView<HolidayDashboardController> {
  const HolidayDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.filteredHolidayList.isEmpty) {
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

        return Column(
          children: [
            Obx(() {
              if (!controller.isSearchVisible.value) {
                return const SizedBox.shrink();
              }

              return Container(
                margin: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.applySearch,
                  decoration: InputDecoration(
                    hintText: "Search by occasion or date",
                    border: InputBorder.none,
                    icon: const Icon(Icons.search),
                    suffixIcon: controller.searchController.text.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        controller.searchController.clear();
                        controller.applySearch('');
                      },
                      icon: const Icon(Icons.close),
                    )
                        : null,
                  ),
                ),
              );
            }),

            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshHolidays,
                child: controller.filteredHolidayList.isEmpty
                    ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 220.h),
                    Center(
                      child: Text(
                        "No holidays found",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                )
                    : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  itemCount: controller.filteredHolidayList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = controller.filteredHolidayList[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: Colors.blueGrey.withOpacity(0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35.h,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(14.r),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF10B981),
                                        Color(0xFF059669),
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.event_available_rounded,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (item.occasion ?? "").trim().isNotEmpty
                                            ? item.occasion!
                                            : "No Occasion",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF1F2937),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        controller.formatDate(
                                          item.dateHoliday ?? "",
                                        ),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 2.h),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 1.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      elevation: 0,
      backgroundColor: const Color(0xFF2C4A6B),
      centerTitle: true,
      title: Obx(
            () => Column(
          children: [
            Text(
              controller.schoolName.value.isEmpty
                  ? "Holiday List"
                  : controller.schoolName.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17.sp,
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
      actions: [
        Obx(
              () => IconButton(
            onPressed: controller.toggleSearch,
            icon: Icon(
              controller.isSearchVisible.value ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _detailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black87,
            height: 1.45,
          ),
          children: [
            TextSpan(
              text: "$title: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value.trim().isEmpty ? "N/A" : value,
            ),
          ],
        ),
      ),
    );
  }
}