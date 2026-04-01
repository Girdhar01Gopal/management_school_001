import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/notification_controller.dart';

class NotificationDashboardScreen
    extends GetView<NotificationDashboardController> {
  const NotificationDashboardScreen({super.key});

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
            controller.filteredNotificationList.isEmpty) {
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
                    hintText: "Search by name or date",
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
                onRefresh: controller.refreshNotifications,
                child: controller.filteredNotificationList.isEmpty
                    ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 220.h),
                    Center(
                      child: Text(
                        "No notifications found",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                )
                    : Container(
                  margin: EdgeInsets.only(top: 12.h),
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
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    itemCount: controller.filteredNotificationList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final item =
                      controller.filteredNotificationList[index];

                      final hasFile =
                          (item.notificationFile ?? "").trim().isNotEmpty;
                      final fileUrl = controller.getFullFileUrl(
                        item.notificationFile ?? "",
                      );
                      final isImage = controller.isImageFile(
                        item.notificationFile ?? "",
                      );

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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (hasFile && isImage)
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18.r),
                                  topRight: Radius.circular(18.r),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      Dialog(
                                        insetPadding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 24.h,
                                        ),
                                        backgroundColor: Colors.transparent,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(8.w),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(
                                                  18.r,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  14.r,
                                                ),
                                                child: InteractiveViewer(
                                                  minScale: 0.8,
                                                  maxScale: 4.0,
                                                  child: Image.network(
                                                    fileUrl,
                                                    fit: BoxFit.contain,
                                                    errorBuilder:
                                                        (_, __, ___) {
                                                      return Container(
                                                        height: 250.h,
                                                        alignment:
                                                        Alignment
                                                            .center,
                                                        child: const Text(
                                                          "Unable to load image",
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10.h,
                                              right: 10.w,
                                              child: InkWell(
                                                onTap: () => Get.back(),
                                                child: Container(
                                                  padding:
                                                  EdgeInsets.all(6.w),
                                                  decoration:
                                                  const BoxDecoration(
                                                    color: Colors.black54,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 18.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    fileUrl,
                                    height: 190.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) {
                                      return Container(
                                        height: 160.h,
                                        width: double.infinity,
                                        color: Colors.grey.shade200,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Unable to load image",
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                            Padding(
                              padding: EdgeInsets.all(14.w),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 46.h,
                                        width: 46.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(14.r),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF3B82F6),
                                              Color(0xFF1D4ED8),
                                            ],
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.notifications_active_rounded,
                                          color: Colors.white,
                                          size: 22.sp,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (item.title ?? "").isNotEmpty
                                                  ? item.title!
                                                  : "No Title",
                                              maxLines: 2,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                const Color(0xFF1F2937),
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              controller.formatDate(
                                                item.createDate ?? "",
                                              ),
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.black54,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      IconButton(
                                        onPressed: () {
                                          controller.shareNotification(item);
                                        },
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.red,
                                          size: 22.sp,
                                        ),
                                        tooltip: "Share",
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 12.h),

                                  Text(
                                    (item.message ?? "").trim().isNotEmpty
                                        ? item.message!
                                        : "No message available",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  Wrap(
                                    runSpacing: 8.h,
                                    children: [
                                      _detailRow(
                                        "By",
                                        controller.getSenderName(item),
                                      ),
                                      _detailRow(
                                        "Session",
                                        (item.session ?? "").isNotEmpty
                                            ? item.session!
                                            : "N/A",
                                      ),
                                      _detailRow(
                                        "Type",
                                        (item.type ?? "").isNotEmpty
                                            ? item.type!
                                            : "N/A",
                                      ),
                                      _detailRow(
                                        "Class / Section",
                                        controller.getClassSection(item),
                                      ),
                                      _detailRow(
                                        "Created By",
                                        (item.createBy ?? "").isNotEmpty
                                            ? item.createBy!
                                            : "N/A",
                                      ),
                                    ],
                                  ),

                                  if (hasFile && !isImage) ...[
                                    SizedBox(height: 12.h),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                        BorderRadius.circular(12.r),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.attach_file_rounded,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              item.notificationFile ?? "",
                                              maxLines: 1,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
                  ? "Notifications"
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