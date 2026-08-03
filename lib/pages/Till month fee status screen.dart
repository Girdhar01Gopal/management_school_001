/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/Till month fee status controller.dart';


/// Formats a number like 16214890.0 => "1,62,14,890.00"
/// (Indian numbering system: last 3 digits together, then groups of 2)
/// without pulling in intl.
String formatAmount(double value) {
  final isNegative = value < 0;
  final fixed = value.abs().toStringAsFixed(2);
  final parts = fixed.split('.');
  final intPart = parts[0];

  String withCommas;
  if (intPart.length <= 3) {
    withCommas = intPart;
  } else {
    final lastThree = intPart.substring(intPart.length - 3);
    var remaining = intPart.substring(0, intPart.length - 3);

    final groups = <String>[];
    while (remaining.length > 2) {
      groups.insert(0, remaining.substring(remaining.length - 2));
      remaining = remaining.substring(0, remaining.length - 2);
    }
    if (remaining.isNotEmpty) groups.insert(0, remaining);

    withCommas = "${groups.join(',')},$lastThree";
  }

  return "${isNegative ? '-' : ''}$withCommas.${parts[1]}";
}

class _TMS {
  static const bg      = Color(0xFF070D16);
  static const surface = Color(0xFF0E1923);
  static const border  = Color(0xFF1E3048);
  static const cyan    = Color(0xFF00E5FF);
  static const gold    = Color(0xFFFFCA28);
  static const white   = Colors.white;
  static const white70 = Color(0xB3FFFFFF);
  static const white40 = Color(0x66FFFFFF);
  static const white15 = Color(0x26FFFFFF);

  static const green = Color(0xFF16A34A);
  static const blue  = Color(0xFF2563EB);
  static const red   = Color(0xFFDC2626);
}

class TillMonthFeeStatusScreen extends GetView<TillMonthFeeStatusController> {
  const TillMonthFeeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _TMS.bg,
      appBar: _buildAppBar(context),
      body: Obx(() {
        final bool hasData = controller.totalRow.value != null;

        // Full-screen shimmer/error ONLY on the very first load (no data yet).
        // Once data exists, pull-to-refresh / the AppBar refresh button
        // should keep showing the current values while it re-fetches,
        // instead of wiping the screen.
        if (controller.isLoading.value && !hasData) {
          return const _ShimmerSkeleton();
        }
        if (controller.errorMessage.value.isNotEmpty && !hasData) {
          return _ErrorState(
            message: controller.errorMessage.value,
            onRetry: controller.fetchTillMonthData,
          );
        }
        return RefreshIndicator(
          color: _TMS.cyan,
          backgroundColor: _TMS.surface,
          onRefresh: controller.fetchTillMonthData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TillMonthBanner(label: controller.tillMonthLabel.value),
                SizedBox(height: 18.h),
                _StatCard(
                  title: "Total Amount",
                  amount: controller.totalAmount,
                  color: _TMS.green,
                  schoolFee: controller.totalAmountSchool,
                  transportFee: controller.totalAmountTransport,
                ),
                SizedBox(height: 14.h),
                _StatCard(
                  title: "Total Received",
                  amount: controller.totalReceived,
                  color: _TMS.blue,
                  schoolFee: controller.totalReceivedSchool,
                  transportFee: controller.totalReceivedTransport,
                ),
                SizedBox(height: 14.h),
                _StatCard(
                  title: "Total Pending",
                  amount: controller.totalPending,
                  color: _TMS.red,
                  schoolFee: controller.totalPendingSchool,
                  transportFee: controller.totalPendingTransport,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(68.h),
      child: Container(
        decoration: BoxDecoration(
          color: _TMS.surface,
          border: Border(
            bottom: BorderSide(color: _TMS.cyan.withOpacity(0.18), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: _TMS.cyan.withOpacity(0.12),
              blurRadius: 28,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              height: 56.h,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: _TMS.cyan, size: 18.sp),
                  ),
                  Expanded(
                    child: Text(
                      "Till Month Fee Status Report",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                        color: _TMS.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Obx(
                        () => IconButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.fetchTillMonthData(),
                      icon: controller.isLoading.value
                          ? SizedBox(
                        width: 18.sp,
                        height: 18.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _TMS.gold,
                        ),
                      )
                          : Icon(Icons.refresh_rounded,
                          color: _TMS.gold, size: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Banner: "Till July 2026" ────────────────────────────────────────────────
class _TillMonthBanner extends StatelessWidget {
  final String label;
  const _TillMonthBanner({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [_TMS.gold.withOpacity(0.16), _TMS.gold.withOpacity(0.05)],
        ),
        border: Border.all(color: _TMS.gold.withOpacity(0.3), width: 1),
      ),
      child: Center(
        child: Text(
          label.isEmpty ? "Till Date" : label,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
            color: _TMS.gold,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String title;
  final double amount;
  final double schoolFee;
  final double transportFee;
  final Color color;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.schoolFee,
    required this.transportFee,
    required this.color,
  });

  String _fmt(double v) => formatAmount(v);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _fmt(amount),
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SubLine(label: "School Fees :-", value: _fmt(schoolFee)),
              _SubLine(label: "Transport Fees :-", value: _fmt(transportFee)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubLine extends StatelessWidget {
  final String label;
  final String value;
  const _SubLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shimmer Skeleton ─────────────────────────────────────────────────────────
class _ShimmerSkeleton extends StatelessWidget {
  const _ShimmerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF0E1923),
      highlightColor: const Color(0xFF1C3248),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ShimBox(height: 60.h, radius: 16.r),
            SizedBox(height: 18.h),
            _ShimBox(height: 130.h, radius: 20.r),
            SizedBox(height: 14.h),
            _ShimBox(height: 130.h, radius: 20.r),
            SizedBox(height: 14.h),
            _ShimBox(height: 130.h, radius: 20.r),
          ],
        ),
      ),
    );
  }
}

class _ShimBox extends StatelessWidget {
  final double? width, height;
  final double radius;
  const _ShimBox({this.width, this.height, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// ─── Error State ──────────────────────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF4D4D).withOpacity(0.1),
                border: Border.all(
                  color: const Color(0xFFFF4D4D).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                color: const Color(0xFFFF4D4D),
                size: 38.sp,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: _TMS.white40),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: _TMS.cyan.withOpacity(0.4)),
                ),
              ),
              child: Text(
                "Retry",
                style: TextStyle(color: _TMS.cyan, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/Till month fee status controller.dart';


/// Formats a number like 16214890.0 => "1,62,14,890.00"
/// (Indian numbering system: last 3 digits together, then groups of 2)
/// without pulling in intl.
String formatAmount(double value) {
  final isNegative = value < 0;
  final fixed = value.abs().toStringAsFixed(2);
  final parts = fixed.split('.');
  final intPart = parts[0];

  String withCommas;
  if (intPart.length <= 3) {
    withCommas = intPart;
  } else {
    final lastThree = intPart.substring(intPart.length - 3);
    var remaining = intPart.substring(0, intPart.length - 3);

    final groups = <String>[];
    while (remaining.length > 2) {
      groups.insert(0, remaining.substring(remaining.length - 2));
      remaining = remaining.substring(0, remaining.length - 2);
    }
    if (remaining.isNotEmpty) groups.insert(0, remaining);

    withCommas = "${groups.join(',')},$lastThree";
  }

  return "${isNegative ? '-' : ''}$withCommas.${parts[1]}";
}

// ── Design tokens (same palette as Dashboard) ───────────────────────────────
class _TMS {
  static const bg      = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF3EDF7);
  static const border  = Color(0xFFE7E0EC);
  static const cyan    = Color(0xFF4A4458);
  static const gold    = Color(0xFFB8860B);
  static const white   = Color(0xFF1D1B20);
  static const white70 = Color(0xFF49454F);
  static const white40 = Color(0xFF79747E);
  static const white15 = Color(0xFFE7E0EC);

  static const green = Color(0xFF1F4A3D);
  static const blue  = Color(0xFF23414F);
  static const red   = Color(0xFF4A2438);
}

class TillMonthFeeStatusScreen extends GetView<TillMonthFeeStatusController> {
  const TillMonthFeeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _TMS.bg,
      appBar: _buildAppBar(context),
      body: Obx(() {
        final bool hasData = controller.totalRow.value != null;

        // Full-screen shimmer/error ONLY on the very first load (no data yet).
        // Once data exists, pull-to-refresh / the AppBar refresh button
        // should keep showing the current values while it re-fetches,
        // instead of wiping the screen.
        if (controller.isLoading.value && !hasData) {
          return const _ShimmerSkeleton();
        }
        if (controller.errorMessage.value.isNotEmpty && !hasData) {
          return _ErrorState(
            message: controller.errorMessage.value,
            onRetry: controller.fetchTillMonthData,
          );
        }
        return RefreshIndicator(
          color: _TMS.cyan,
          backgroundColor: _TMS.surface,
          onRefresh: controller.fetchTillMonthData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TillMonthBanner(label: controller.tillMonthLabel.value),
                SizedBox(height: 18.h),
                _StatCard(
                  title: "💰 Total Amount",
                  amount: controller.totalAmount,
                  color: _TMS.green,
                  schoolFee: controller.totalAmountSchool,
                  transportFee: controller.totalAmountTransport,
                ),
                SizedBox(height: 14.h),
                _StatCard(
                  title: "✅ Total Received",
                  amount: controller.totalReceived,
                  color: _TMS.blue,
                  schoolFee: controller.totalReceivedSchool,
                  transportFee: controller.totalReceivedTransport,
                ),
                SizedBox(height: 14.h),
                _StatCard(
                  title: "⏳ Total Pending",
                  amount: controller.totalPending,
                  color: _TMS.red,
                  schoolFee: controller.totalPendingSchool,
                  transportFee: controller.totalPendingTransport,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(68.h),
      child: Container(
        decoration: BoxDecoration(
          color: _TMS.surface,
          border: Border(
            bottom: BorderSide(color: _TMS.cyan.withOpacity(0.18), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: _TMS.cyan.withOpacity(0.12),
              blurRadius: 28,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SizedBox(
              height: 56.h,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: _TMS.cyan, size: 18.sp),
                  ),
                  Expanded(
                    child: Text(
                      "📊 Till Month Fee Status Report",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w900,
                        color: _TMS.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Obx(
                        () => IconButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.fetchTillMonthData(),
                      icon: controller.isLoading.value
                          ? SizedBox(
                        width: 18.sp,
                        height: 18.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _TMS.gold,
                        ),
                      )
                          : Icon(Icons.refresh_rounded,
                          color: _TMS.gold, size: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Banner: "Till July 2026" ────────────────────────────────────────────────
class _TillMonthBanner extends StatelessWidget {
  final String label;
  const _TillMonthBanner({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [_TMS.gold.withOpacity(0.16), _TMS.gold.withOpacity(0.05)],
        ),
        border: Border.all(color: _TMS.gold.withOpacity(0.3), width: 1),
      ),
      child: Center(
        child: Text(
          "📅 ${label.isEmpty ? "Till Date" : label}",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
            color: _TMS.gold,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

// ─── Stat Card ────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String title;
  final double amount;
  final double schoolFee;
  final double transportFee;
  final Color color;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.schoolFee,
    required this.transportFee,
    required this.color,
  });

  String _fmt(double v) => formatAmount(v);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.75)],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _fmt(amount),
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SubLine(label: "School Fees :-", value: _fmt(schoolFee)),
              _SubLine(label: "Transport Fees :-", value: _fmt(transportFee)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubLine extends StatelessWidget {
  final String label;
  final String value;
  const _SubLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shimmer Skeleton ─────────────────────────────────────────────────────────
class _ShimmerSkeleton extends StatelessWidget {
  const _ShimmerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFF3EDF7),
      highlightColor: const Color(0xFFFFFFFF),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ShimBox(height: 60.h, radius: 16.r),
            SizedBox(height: 18.h),
            _ShimBox(height: 130.h, radius: 20.r),
            SizedBox(height: 14.h),
            _ShimBox(height: 130.h, radius: 20.r),
            SizedBox(height: 14.h),
            _ShimBox(height: 130.h, radius: 20.r),
          ],
        ),
      ),
    );
  }
}

class _ShimBox extends StatelessWidget {
  final double? width, height;
  final double radius;
  const _ShimBox({this.width, this.height, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// ─── Error State ──────────────────────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF4D4D).withOpacity(0.1),
                border: Border.all(
                  color: const Color(0xFFFF4D4D).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                color: const Color(0xFFFF4D4D),
                size: 38.sp,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: _TMS.white40),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18.h),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: _TMS.cyan.withOpacity(0.4)),
                ),
              ),
              child: Text(
                "Retry",
                style: TextStyle(color: _TMS.cyan, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}