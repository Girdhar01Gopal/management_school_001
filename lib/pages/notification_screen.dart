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
      backgroundColor: const Color(0xFFF0F4FA),
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
                    : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: controller.filteredNotificationList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14.h),
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

                    // getClassSection se "Class - Section" string aata hai
                    // usse ' - ' se split karke alag dikhate hain
                    final classSection = controller.getClassSection(item);
                    final parts = classSection.split(' - ');
                    final className =
                    parts.isNotEmpty ? parts[0].trim() : classSection;
                    final sectionName =
                    parts.length > 1 ? parts[1].trim() : "";

                    return _buildNotificationCard(
                      item: item,
                      hasFile: hasFile,
                      fileUrl: fileUrl,
                      isImage: isImage,
                      className: className,
                      sectionName: sectionName,
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

  Widget _buildNotificationCard({
    required dynamic item,
    required bool hasFile,
    required String fileUrl,
    required bool isImage,
    required String className,
    required String sectionName,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C4A6B).withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image (if any) ──
          if (hasFile && isImage)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: GestureDetector(
                onTap: () => _showImageDialog(fileUrl),
                child: Image.network(
                  fileUrl,
                  height: 190.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160.h,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Text("Unable to load image"),
                  ),
                ),
              ),
            ),

          // ── Header: Icon + Title + Date + Share ──
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 14.h, 6.w, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bell icon box
                Container(
                  height: 46.h,
                  width: 46.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),

                // Title + Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (item.title ?? "").isNotEmpty
                            ? item.title!
                            : "No Title",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 11.sp,
                            color: Colors.black45,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            controller.formatDate(item.createDate ?? ""),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Share button
                IconButton(
                  onPressed: () => controller.shareNotification(item),
                  icon: Icon(
                    Icons.share,
                    color: Colors.redAccent,
                    size: 21.sp,
                  ),
                  tooltip: "Share",
                ),
              ],
            ),
          ),

          // ── Message ──
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 0),
            child: Text(
              (item.message ?? "").trim().isNotEmpty
                  ? item.message!
                  : "No message available",
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
                height: 1.55,
              ),
            ),
          ),

          // ── Non-image file attachment ──
          if (hasFile && !isImage) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 0),
              child: Container(
                width: double.infinity,
                padding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.attach_file_rounded),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        item.notificationFile ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          SizedBox(height: 12.h),

          // ── Footer: Class + Section alag alag rows ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FD),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF2C4A6B).withOpacity(0.08),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Class row
                _footerInfoRow(
                  icon: Icons.school_rounded,
                  label: "Class",
                  value: className.isNotEmpty ? className : "N/A",
                  iconColor: const Color(0xFF3B82F6),
                ),
                SizedBox(height: 8.h),
                // Section row
                _footerInfoRow(
                  icon: Icons.table_chart_rounded,
                  label: "Section",
                  value: sectionName.isNotEmpty ? sectionName : "N/A",
                  iconColor: const Color(0xFF7C3AED),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Footer info row: icon + label: value (inline)
  Widget _footerInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 15.sp, color: iconColor),
        SizedBox(width: 6.w),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value.trim().isEmpty ? "N/A" : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
        ),
      ],
    );
  }

  void _showImageDialog(String fileUrl) {
    Get.dialog(
      Dialog(
        insetPadding:
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Image.network(
                    fileUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      height: 250.h,
                      alignment: Alignment.center,
                      child: const Text("Unable to load image"),
                    ),
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
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child:
                  Icon(Icons.close, color: Colors.white, size: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
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
}