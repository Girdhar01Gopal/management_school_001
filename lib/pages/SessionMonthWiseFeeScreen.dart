/*import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/SessionMonthWiseFeecontroller.dart';
import '../models/session_month_wise_fee.dart';


// ── Design tokens (same palette as existing Dashboard) ─────────────────────
class _DS {
  static const bg      = Color(0xFF070D16);
  static const surface = Color(0xFF0E1923);
  static const card    = Color(0xFF111D2B);
  static const border  = Color(0xFF1E3048);
  static const cyan    = Color(0xFF00E5FF);
  static const cyanDim = Color(0xFF00B8CC);
  static const gold    = Color(0xFFFFCA28);
  static const green   = Color(0xFF22C55E);
  static const greenDk = Color(0xFF15803D);
  static const blue    = Color(0xFF3B82F6);
  static const blueDk  = Color(0xFF1D4ED8);
  static const orange  = Color(0xFFFB923C);
  static const orangeDk= Color(0xFFEA580C);
  static const white   = Colors.white;
  static const white70 = Color(0xB3FFFFFF);
  static const white40 = Color(0x66FFFFFF);
  static const white15 = Color(0x26FFFFFF);
}

// ═══════════════════════════════════════════════════════════════════════════
class SessionMonthWiseFeeScreen
    extends GetView<SessionMonthWiseFeeController> {
  const SessionMonthWiseFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _DS.bg,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) return _ShimmerSkeleton();
        if (controller.errorMessage.value.isNotEmpty &&
            controller.feeDataList.isEmpty) {
          return _ErrorState(message: controller.errorMessage.value);
        }
        return _Body(controller: controller);
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(68.h),
      child: Container(
        decoration: BoxDecoration(
          color: _DS.surface,
          border: Border(
            bottom: BorderSide(color: _DS.cyan.withOpacity(0.18), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: _DS.cyan.withOpacity(0.12),
              blurRadius: 28,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 56.h,
              child: Row(
                children: [
                  // Back button
                  _IconBtn(
                    icon: Icons.arrow_back_ios_new_rounded,
                    color: _DS.cyan,
                    onTap: () => Get.back(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ALL MONTH FEE REPORT',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            color: _DS.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Obx(() => _SessionBadge(
                          session: controller.selectedSession.value,
                        )),
                      ],
                    ),
                  ),
                  // Refresh
                  _IconBtn(
                    icon: Icons.refresh_rounded,
                    color: _DS.gold,
                    onTap: controller.fetchFeeData,
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

// ── Body ────────────────────────────────────────────────────────────────────
class _Body extends StatelessWidget {
  final SessionMonthWiseFeeController controller;
  const _Body({required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: _DS.cyan,
      backgroundColor: _DS.surface,
      onRefresh: controller.fetchFeeData,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ── Session Dropdown ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 0),
              child: _SessionDropdown(controller: controller),
            ),
          ),

          // ── Summary Strip ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: _SummaryStrip(controller: controller),
            ),
          ),

          // ── Section label ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 14.h),
              child: _SectionLabel(label: 'All Month Fee Status Report'),
            ),
          ),

          // ── Month cards list ──────────────────────────────────────────────
          Obx(() {
            if (controller.feeDataList.isEmpty) {
              return SliverToBoxAdapter(
                child: _EmptyState(),
              );
            }
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, i) {
                    final item = controller.feeDataList[i];
                    return _MonthBlock(
                      item: item,
                      controller: controller,
                      index: i,
                    );
                  },
                  childCount: controller.feeDataList.length,
                ),
              ),
            );
          }),

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
        ],
      ),
    );
  }
}

// ── Session Dropdown ─────────────────────────────────────────────────────────
class _SessionDropdown extends StatelessWidget {
  final SessionMonthWiseFeeController controller;
  const _SessionDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedSession.value;
      final sessions = controller.sessionStrings; // List<String> from getter

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: _DS.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _DS.cyan.withOpacity(0.30), width: 1),
          boxShadow: [
            BoxShadow(
              color: _DS.cyan.withOpacity(0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded, color: _DS.cyan, size: 18.sp),
            SizedBox(width: 10.w),
            Text(
              'Session',
              style: TextStyle(
                fontSize: 13.sp,
                color: _DS.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: controller.isSessionLoading.value
                  ? _shimmerPill()
                  : DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: sessions.contains(selected) ? selected : null,
                  dropdownColor: _DS.card,
                  iconEnabledColor: _DS.cyan,
                  style: TextStyle(
                    color: _DS.cyan,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  isExpanded: true,
                  items: sessions
                      .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s),
                  ))
                      .toList(),
                  onChanged: controller.onSessionChanged,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: controller.fetchFeeData,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_DS.cyan, _DS.cyanDim],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: _DS.cyan.withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Go!',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w900,
                    color: _DS.bg,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _shimmerPill() {
    return Shimmer.fromColors(
      baseColor: _DS.surface,
      highlightColor: _DS.border,
      child: Container(
        height: 20.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

// ── Summary Strip (4 KPI pills) ──────────────────────────────────────────────
class _SummaryStrip extends StatelessWidget {
  final SessionMonthWiseFeeController controller;
  const _SummaryStrip({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = [
        _SummaryItem(
          label: 'Total Fee',
          value: controller.fmt(controller.summaryTotalFee.value),
          color: _DS.green,
          icon: Icons.receipt_long_rounded,
        ),
        _SummaryItem(
          label: 'Paid',
          value: controller.fmt(controller.summaryTotalPaid.value),
          color: _DS.blue,
          icon: Icons.check_circle_rounded,
        ),
        _SummaryItem(
          label: 'Due',
          value: controller.fmt(controller.summaryTotalDue.value),
          color: _DS.orange,
          icon: Icons.pending_actions_rounded,
        ),
        _SummaryItem(
          label: 'Advance',
          value: controller.fmt(controller.summaryTotalAdvance.value),
          color: _DS.gold,
          icon: Icons.trending_up_rounded,
        ),
      ];

      return Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: _DS.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: _DS.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 3.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [_DS.cyan, _DS.cyanDim],
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Session Summary',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: _DS.white70,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: items
                  .map((item) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: _SummaryPill(item: item),
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}

class _SummaryItem {
  final String label, value;
  final Color color;
  final IconData icon;
  const _SummaryItem(
      {required this.label,
        required this.value,
        required this.color,
        required this.icon});
}

class _SummaryPill extends StatelessWidget {
  final _SummaryItem item;
  const _SummaryPill({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: item.color.withOpacity(0.09),
        border: Border.all(color: item.color.withOpacity(0.22), width: 1),
      ),
      child: Column(
        children: [
          Icon(item.icon, color: item.color, size: 16.sp),
          SizedBox(height: 5.h),
          FittedBox(
            child: Text(
              item.value,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w900,
                color: item.color,
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 9.sp,
              color: _DS.white40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Month Block (header + 3 cards) ───────────────────────────────────────────
class _MonthBlock extends StatelessWidget {
  final SessionMonthWiseFee item;
  final SessionMonthWiseFeeController controller;
  final int index;

  const _MonthBlock({
    required this.item,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentMonth = item.tillMonth == DateTime.now().month;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + index * 60),
      curve: Curves.easeOutCubic,
      builder: (_, v, child) => Opacity(
        opacity: v.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - v)),
          child: child,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month label
            _MonthHeader(
              monthName: item.monthName.toUpperCase(),
              isCurrentMonth: isCurrentMonth,
            ),
            SizedBox(height: 10.h),
            // 3 cards in a row
            Row(
              children: [
                // Total Fee
                Expanded(
                  child: _FeeCard(
                    title: 'Total Fee',
                    total: controller.fmt(item.totalFee),
                    line1Label: 'School Fees',
                    line1Value: controller.fmt(item.totalSchoolFee),
                    line2Label: 'Transport Fees',
                    line2Value: controller.fmt(item.totalTransportFee),
                    gradient: const [Color(0xFF22C55E), Color(0xFF15803D)],
                    glowColor: _DS.green,
                    // zoom dialog data
                    dialogRows: [
                      _DialogRow('Total Fee', controller.fmt(item.totalFee)),
                      _DialogRow('School Fee', controller.fmt(item.totalSchoolFee)),
                      _DialogRow('Transport Fee', controller.fmt(item.totalTransportFee)),
                      _DialogRow('Net Fee Amount', controller.fmt(item.totalNetFeeAmount)),
                      _DialogRow('School Discount', controller.fmt(item.totalSchoolDiscount)),
                      _DialogRow('Transport Discount', controller.fmt(item.totalTransportDiscount)),
                      _DialogRow('Total Discount', controller.fmt(item.totalDiscount)),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Total Paid
                Expanded(
                  child: _FeeCard(
                    title: 'Total Paid',
                    total: controller.fmt(item.totalPaid),
                    line1Label: 'School Fees',
                    line1Value: controller.fmt(item.totalSchoolFeePaid),
                    line2Label: 'Transport Fees',
                    line2Value: controller.fmt(item.totalTransportFeePaid),
                    gradient: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    glowColor: _DS.blue,
                    dialogRows: [
                      _DialogRow('Total Paid', controller.fmt(item.totalPaid)),
                      _DialogRow('School Fee Paid', controller.fmt(item.totalSchoolFeePaid)),
                      _DialogRow('Transport Fee Paid', controller.fmt(item.totalTransportFeePaid)),
                      _DialogRow('Total Paid Fee', controller.fmt(item.totalPaidFee)),
                      _DialogRow('Grand Total Fee', controller.fmt(item.grandTotalFee)),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Total Due / Advance
                Expanded(
                  child: _FeeCard(
                    title: 'Due / Advance',
                    total:
                    '${controller.fmt(item.totalDue)} /\n${controller.fmt(item.totalAdvance)}',
                    line1Label: 'School Due',
                    line1Value: controller.fmt(item.totalSchoolDue),
                    line2Label: 'Transport Due',
                    line2Value: controller.fmt(item.totalTransportDue),
                    gradient: const [Color(0xFFFB923C), Color(0xFFEA580C)],
                    glowColor: _DS.orange,
                    dialogRows: [
                      _DialogRow('Total Due', controller.fmt(item.totalDue)),
                      _DialogRow('School Due', controller.fmt(item.totalSchoolDue)),
                      _DialogRow('Transport Due', controller.fmt(item.totalTransportDue)),
                      _DialogRow('Total Advance', controller.fmt(item.totalAdvance)),
                      _DialogRow('School Advance', controller.fmt(item.totalSchoolAdvance)),
                      _DialogRow('Transport Advance', controller.fmt(item.totalTransportAdvance)),
                      _DialogRow('Due Amount', controller.fmt(item.totalDueAmount)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final String monthName;
  final bool isCurrentMonth;
  const _MonthHeader({required this.monthName, this.isCurrentMonth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isCurrentMonth
            ? _DS.cyan.withOpacity(0.10)
            : _DS.surface,
        border: Border.all(
          color: isCurrentMonth
              ? _DS.cyan.withOpacity(0.55)
              : _DS.border.withOpacity(0.6),
          width: isCurrentMonth ? 1.5 : 1,
        ),
        boxShadow: isCurrentMonth
            ? [
          BoxShadow(
            color: _DS.cyan.withOpacity(0.14),
            blurRadius: 12,
            offset: const Offset(0, 3),
          )
        ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            monthName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              color: isCurrentMonth ? _DS.cyan : _DS.white,
              letterSpacing: 2,
            ),
          ),
          if (isCurrentMonth) ...[
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: const LinearGradient(
                  colors: [_DS.cyan, _DS.cyanDim],
                ),
              ),
              child: Text(
                'CURRENT',
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w900,
                  color: _DS.bg,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Dialog row data model ────────────────────────────────────────────────────
class _DialogRow {
  final String label;
  final String value;
  const _DialogRow(this.label, this.value);
}

// ── Fee Card (tappable → zoom bottom sheet) ───────────────────────────────────
class _FeeCard extends StatefulWidget {
  final String title;
  final String total;
  final String line1Label, line1Value;
  final String line2Label, line2Value;
  final List<Color> gradient;
  final Color glowColor;
  final List<_DialogRow> dialogRows;

  const _FeeCard({
    required this.title,
    required this.total,
    required this.line1Label,
    required this.line1Value,
    required this.line2Label,
    required this.line2Value,
    required this.gradient,
    required this.glowColor,
    required this.dialogRows,
  });

  @override
  State<_FeeCard> createState() => _FeeCardState();
}

class _FeeCardState extends State<_FeeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
    );
    _scale = Tween(begin: 1.0, end: 0.93)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _showZoomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ZoomSheet(
        title: widget.title,
        total: widget.total,
        gradient: widget.gradient,
        glowColor: widget.glowColor,
        rows: widget.dialogRows,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _c.forward(),
      onTapUp: (_) {
        _c.reverse();
        _showZoomDialog(context);
      },
      onTapCancel: () => _c.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradient,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.28),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + tap hint
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.90),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.open_in_full_rounded,
                    color: Colors.white.withOpacity(0.55),
                    size: 10.sp,
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              // Main total
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.total,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Divider
              Container(
                height: 1.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.40),
                      Colors.white.withOpacity(0.08),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              _SubLine(label: widget.line1Label, value: widget.line1Value),
              SizedBox(height: 3.h),
              _SubLine(label: widget.line2Label, value: widget.line2Value),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Zoom Bottom Sheet ─────────────────────────────────────────────────────────
class _ZoomSheet extends StatelessWidget {
  final String title;
  final String total;
  final List<Color> gradient;
  final Color glowColor;
  final List<_DialogRow> rows;

  const _ZoomSheet({
    required this.title,
    required this.total,
    required this.gradient,
    required this.glowColor,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1923),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: glowColor.withOpacity(0.30), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.20),
            blurRadius: 32,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: glowColor.withOpacity(0.40),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 18.h),

          // Header card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      FittedBox(
                        child: Text(
                          total,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Detail rows
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: rows.asMap().entries.map((entry) {
                final isLast = entry.key == rows.length - 1;
                return Column(
                  children: [
                    _DetailRow(
                      row: entry.value,
                      glowColor: glowColor,
                    ),
                    if (!isLast)
                      Divider(
                        color: glowColor.withOpacity(0.10),
                        height: 1,
                        thickness: 1,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final _DialogRow row;
  final Color glowColor;
  const _DetailRow({required this.row, required this.glowColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 11.h),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: glowColor.withOpacity(0.70),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              row.label,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xB3FFFFFF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubLine extends StatelessWidget {
  final String label, value;
  const _SubLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 8.5.sp, color: Colors.white.withOpacity(0.80)),
        children: [
          TextSpan(
            text: '$label :- ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.5.w,
          height: 18.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_DS.cyan, _DS.cyanDim],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: _DS.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(height: 1, width: 30.w, color: _DS.border),
      ],
    );
  }
}

// ── Session Badge ─────────────────────────────────────────────────────────────
class _SessionBadge extends StatelessWidget {
  final String session;
  const _SessionBadge({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: LinearGradient(
          colors: [
            _DS.cyan.withOpacity(0.18),
            _DS.cyanDim.withOpacity(0.08),
          ],
        ),
        border: Border.all(color: _DS.cyan.withOpacity(0.35), width: 0.8),
      ),
      child: Text(
        session.isEmpty ? 'Loading...' : 'Session $session',
        style: TextStyle(
          fontSize: 9.5.sp,
          fontWeight: FontWeight.w700,
          color: _DS.cyan,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ── Icon Button (same as dashboard) ──────────────────────────────────────────
class _IconBtn extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.color, required this.onTap});

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween(begin: 1.0, end: 0.88)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _c.forward(),
      onTapUp: (_) {
        _c.reverse();
        widget.onTap();
      },
      onTapCancel: () => _c.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: widget.color.withOpacity(0.1),
            border: Border.all(color: widget.color.withOpacity(0.25), width: 1),
          ),
          child: Icon(widget.icon, color: widget.color, size: 19),
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        children: [
          Icon(Icons.insert_chart_outlined_rounded,
              color: _DS.white15, size: 52.sp),
          SizedBox(height: 14.h),
          Text(
            'No fee data available\nfor this session',
            style: TextStyle(fontSize: 13.sp, color: _DS.white40, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Error State ───────────────────────────────────────────────────────────────
class _ErrorState extends StatefulWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  State<_ErrorState> createState() => _ErrorStateState();
}

class _ErrorStateState extends State<_ErrorState>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _scale = CurvedAnimation(parent: _c, curve: Curves.elasticOut);
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _DS.bg,
      child: Center(
        child: ScaleTransition(
          scale: _scale,
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
                        width: 1.5),
                  ),
                  child: Icon(Icons.cloud_off_rounded,
                      color: const Color(0xFFFF4D4D), size: 38.sp),
                ),
                SizedBox(height: 18.h),
                Text(
                  widget.message,
                  style: TextStyle(fontSize: 13.sp, color: _DS.white40),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shimmer Skeleton ──────────────────────────────────────────────────────────
class _ShimmerSkeleton extends StatelessWidget {
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
            _ShimBox(height: 54.h, radius: 14.r),
            SizedBox(height: 14.h),
            _ShimBox(height: 90.h, radius: 18.r),
            SizedBox(height: 20.h),
            _ShimBox(height: 14.h, width: 200.w, radius: 8.r),
            SizedBox(height: 14.h),
            ...List.generate(
              3,
                  (_) => Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    _ShimBox(height: 38.h, radius: 12.r),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(child: _ShimBox(height: 100.h, radius: 16.r)),
                        SizedBox(width: 8.w),
                        Expanded(child: _ShimBox(height: 100.h, radius: 16.r)),
                        SizedBox(width: 8.w),
                        Expanded(child: _ShimBox(height: 100.h, radius: 16.r)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/SessionMonthWiseFeecontroller.dart';
import '../models/session_month_wise_fee.dart';


// ── Design tokens (same palette as Dashboard) ───────────────────────────────
class _DS {
  static const bg       = Color(0xFFFFFFFF);
  static const surface  = Color(0xFFF3EDF7);
  static const card     = Color(0xFFF7F2FA);
  static const border   = Color(0xFFE7E0EC);
  static const cyan     = Color(0xFF4A4458);
  static const cyanDim  = Color(0xFF7A7289);
  static const gold     = Color(0xFFB8860B);
  static const green    = Color(0xFF1F4A3D);
  static const greenDk  = Color(0xFF16362C);
  static const blue     = Color(0xFF23414F);
  static const blueDk   = Color(0xFF1A303A);
  static const orange   = Color(0xFF4A2E22);
  static const orangeDk = Color(0xFF361F17);
  static const white    = Color(0xFF1D1B20);
  static const white70  = Color(0xFF49454F);
  static const white40  = Color(0xFF79747E);
  static const white15  = Color(0xFFE7E0EC);
}

// ═══════════════════════════════════════════════════════════════════════════
class SessionMonthWiseFeeScreen
    extends GetView<SessionMonthWiseFeeController> {
  const SessionMonthWiseFeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _DS.bg,
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) return _ShimmerSkeleton();
        if (controller.errorMessage.value.isNotEmpty &&
            controller.feeDataList.isEmpty) {
          return _ErrorState(message: controller.errorMessage.value);
        }
        return _Body(controller: controller);
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(68.h),
      child: Container(
        decoration: BoxDecoration(
          color: _DS.surface,
          border: Border(
            bottom: BorderSide(color: _DS.cyan.withOpacity(0.18), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: _DS.cyan.withOpacity(0.12),
              blurRadius: 28,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 56.h,
              child: Row(
                children: [
                  // Back button
                  _IconBtn(
                    icon: Icons.arrow_back_ios_new_rounded,
                    color: _DS.cyan,
                    onTap: () => Get.back(),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '📊 ALL MONTH FEE REPORT',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            color: _DS.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Obx(() => _SessionBadge(
                          session: controller.selectedSession.value,
                        )),
                      ],
                    ),
                  ),
                  // Refresh
                  _IconBtn(
                    icon: Icons.refresh_rounded,
                    color: _DS.gold,
                    onTap: controller.fetchFeeData,
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

// ── Body ────────────────────────────────────────────────────────────────────
class _Body extends StatelessWidget {
  final SessionMonthWiseFeeController controller;
  const _Body({required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: _DS.cyan,
      backgroundColor: _DS.surface,
      onRefresh: controller.fetchFeeData,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ── Session Dropdown ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 0),
              child: _SessionDropdown(controller: controller),
            ),
          ),

          // ── Summary Strip ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              child: _SummaryStrip(controller: controller),
            ),
          ),

          // ── Section label ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 14.h),
              child: _SectionLabel(label: 'All Month Fee Status Report'),
            ),
          ),

          // ── Month cards list ──────────────────────────────────────────────
          Obx(() {
            if (controller.feeDataList.isEmpty) {
              return SliverToBoxAdapter(
                child: _EmptyState(),
              );
            }
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, i) {
                    final item = controller.feeDataList[i];
                    return _MonthBlock(
                      item: item,
                      controller: controller,
                      index: i,
                    );
                  },
                  childCount: controller.feeDataList.length,
                ),
              ),
            );
          }),

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
        ],
      ),
    );
  }
}

// ── Session Dropdown ─────────────────────────────────────────────────────────
class _SessionDropdown extends StatelessWidget {
  final SessionMonthWiseFeeController controller;
  const _SessionDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedSession.value;
      final sessions = controller.sessionStrings; // List<String> from getter

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: _DS.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _DS.cyan.withOpacity(0.30), width: 1),
          boxShadow: [
            BoxShadow(
              color: _DS.cyan.withOpacity(0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded, color: _DS.cyan, size: 18.sp),
            SizedBox(width: 10.w),
            Text(
              'Session',
              style: TextStyle(
                fontSize: 13.sp,
                color: _DS.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: controller.isSessionLoading.value
                  ? _shimmerPill()
                  : DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: sessions.contains(selected) ? selected : null,
                  dropdownColor: _DS.card,
                  iconEnabledColor: _DS.cyan,
                  style: TextStyle(
                    color: _DS.cyan,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  isExpanded: true,
                  items: sessions
                      .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s),
                  ))
                      .toList(),
                  onChanged: controller.onSessionChanged,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: controller.fetchFeeData,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_DS.cyan, _DS.cyanDim],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: _DS.cyan.withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Go!',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w900,
                    color: _DS.bg,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _shimmerPill() {
    return Shimmer.fromColors(
      baseColor: _DS.surface,
      highlightColor: _DS.border,
      child: Container(
        height: 20.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

// ── Summary Strip (4 KPI pills) ──────────────────────────────────────────────
class _SummaryStrip extends StatelessWidget {
  final SessionMonthWiseFeeController controller;
  const _SummaryStrip({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = [
        _SummaryItem(
          label: 'Total Fee',
          value: controller.fmt(controller.summaryTotalFee.value),
          color: _DS.green,
          icon: Icons.receipt_long_rounded,
        ),
        _SummaryItem(
          label: 'Paid',
          value: controller.fmt(controller.summaryTotalPaid.value),
          color: _DS.blue,
          icon: Icons.check_circle_rounded,
        ),
        _SummaryItem(
          label: 'Due',
          value: controller.fmt(controller.summaryTotalDue.value),
          color: _DS.orange,
          icon: Icons.pending_actions_rounded,
        ),
        _SummaryItem(
          label: 'Advance',
          value: controller.fmt(controller.summaryTotalAdvance.value),
          color: _DS.gold,
          icon: Icons.trending_up_rounded,
        ),
      ];

      return Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: _DS.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: _DS.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 3.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [_DS.cyan, _DS.cyanDim],
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Session Summary',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: _DS.white70,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: items
                  .map((item) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: _SummaryPill(item: item),
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}

class _SummaryItem {
  final String label, value;
  final Color color;
  final IconData icon;
  const _SummaryItem(
      {required this.label,
        required this.value,
        required this.color,
        required this.icon});
}

class _SummaryPill extends StatelessWidget {
  final _SummaryItem item;
  const _SummaryPill({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: item.color.withOpacity(0.09),
        border: Border.all(color: item.color.withOpacity(0.22), width: 1),
      ),
      child: Column(
        children: [
          Icon(item.icon, color: item.color, size: 16.sp),
          SizedBox(height: 5.h),
          FittedBox(
            child: Text(
              item.value,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w900,
                color: item.color,
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 9.sp,
              color: _DS.white40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Month Block (header + 3 cards) ───────────────────────────────────────────
class _MonthBlock extends StatelessWidget {
  final SessionMonthWiseFee item;
  final SessionMonthWiseFeeController controller;
  final int index;

  const _MonthBlock({
    required this.item,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCurrentMonth = item.tillMonth == DateTime.now().month;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + index * 60),
      curve: Curves.easeOutCubic,
      builder: (_, v, child) => Opacity(
        opacity: v.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - v)),
          child: child,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month label
            _MonthHeader(
              monthName: item.monthName.toUpperCase(),
              isCurrentMonth: isCurrentMonth,
            ),
            SizedBox(height: 10.h),
            // 3 cards in a row
            Row(
              children: [
                // Total Fee
                Expanded(
                  child: _FeeCard(
                    title: '💰 Total Fee',
                    total: controller.fmt(item.totalFee),
                    line1Label: 'School Fees',
                    line1Value: controller.fmt(item.totalSchoolFee),
                    line2Label: 'Transport Fees',
                    line2Value: controller.fmt(item.totalTransportFee),
                    gradient: const [Color(0xFF1F4A3D), Color(0xFF16362C)],
                    glowColor: _DS.green,
                    // zoom dialog data
                    dialogRows: [
                      _DialogRow('Total Fee', controller.fmt(item.totalFee)),
                      _DialogRow('School Fee', controller.fmt(item.totalSchoolFee)),
                      _DialogRow('Transport Fee', controller.fmt(item.totalTransportFee)),
                      _DialogRow('Net Fee Amount', controller.fmt(item.totalNetFeeAmount)),
                      _DialogRow('School Discount', controller.fmt(item.totalSchoolDiscount)),
                      _DialogRow('Transport Discount', controller.fmt(item.totalTransportDiscount)),
                      _DialogRow('Total Discount', controller.fmt(item.totalDiscount)),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Total Paid
                Expanded(
                  child: _FeeCard(
                    title: '✅ Total Paid',
                    total: controller.fmt(item.totalPaid),
                    line1Label: 'School Fees',
                    line1Value: controller.fmt(item.totalSchoolFeePaid),
                    line2Label: 'Transport Fees',
                    line2Value: controller.fmt(item.totalTransportFeePaid),
                    gradient: const [Color(0xFF23414F), Color(0xFF1A303A)],
                    glowColor: _DS.blue,
                    dialogRows: [
                      _DialogRow('Total Paid', controller.fmt(item.totalPaid)),
                      _DialogRow('School Fee Paid', controller.fmt(item.totalSchoolFeePaid)),
                      _DialogRow('Transport Fee Paid', controller.fmt(item.totalTransportFeePaid)),
                      _DialogRow('Total Paid Fee', controller.fmt(item.totalPaidFee)),
                      _DialogRow('Grand Total Fee', controller.fmt(item.grandTotalFee)),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // Total Due / Advance
                Expanded(
                  child: _FeeCard(
                    title: '⏳ Due / Advance',
                    total:
                    '${controller.fmt(item.totalDue)} /\n${controller.fmt(item.totalAdvance)}',
                    line1Label: 'School Due',
                    line1Value: controller.fmt(item.totalSchoolDue),
                    line2Label: 'Transport Due',
                    line2Value: controller.fmt(item.totalTransportDue),
                    gradient: const [Color(0xFF4A2E22), Color(0xFF361F17)],
                    glowColor: _DS.orange,
                    dialogRows: [
                      _DialogRow('Total Due', controller.fmt(item.totalDue)),
                      _DialogRow('School Due', controller.fmt(item.totalSchoolDue)),
                      _DialogRow('Transport Due', controller.fmt(item.totalTransportDue)),
                      _DialogRow('Total Advance', controller.fmt(item.totalAdvance)),
                      _DialogRow('School Advance', controller.fmt(item.totalSchoolAdvance)),
                      _DialogRow('Transport Advance', controller.fmt(item.totalTransportAdvance)),
                      _DialogRow('Due Amount', controller.fmt(item.totalDueAmount)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthHeader extends StatelessWidget {
  final String monthName;
  final bool isCurrentMonth;
  const _MonthHeader({required this.monthName, this.isCurrentMonth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isCurrentMonth
            ? _DS.cyan.withOpacity(0.10)
            : _DS.surface,
        border: Border.all(
          color: isCurrentMonth
              ? _DS.cyan.withOpacity(0.55)
              : _DS.border.withOpacity(0.6),
          width: isCurrentMonth ? 1.5 : 1,
        ),
        boxShadow: isCurrentMonth
            ? [
          BoxShadow(
            color: _DS.cyan.withOpacity(0.14),
            blurRadius: 12,
            offset: const Offset(0, 3),
          )
        ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            monthName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              color: isCurrentMonth ? _DS.cyan : _DS.white,
              letterSpacing: 2,
            ),
          ),
          if (isCurrentMonth) ...[
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: const LinearGradient(
                  colors: [_DS.cyan, _DS.cyanDim],
                ),
              ),
              child: Text(
                'CURRENT',
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w900,
                  color: _DS.bg,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Dialog row data model ────────────────────────────────────────────────────
class _DialogRow {
  final String label;
  final String value;
  const _DialogRow(this.label, this.value);
}

// ── Fee Card (tappable → zoom bottom sheet) ───────────────────────────────────
class _FeeCard extends StatefulWidget {
  final String title;
  final String total;
  final String line1Label, line1Value;
  final String line2Label, line2Value;
  final List<Color> gradient;
  final Color glowColor;
  final List<_DialogRow> dialogRows;

  const _FeeCard({
    required this.title,
    required this.total,
    required this.line1Label,
    required this.line1Value,
    required this.line2Label,
    required this.line2Value,
    required this.gradient,
    required this.glowColor,
    required this.dialogRows,
  });

  @override
  State<_FeeCard> createState() => _FeeCardState();
}

class _FeeCardState extends State<_FeeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
    );
    _scale = Tween(begin: 1.0, end: 0.93)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _showZoomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ZoomSheet(
        title: widget.title,
        total: widget.total,
        gradient: widget.gradient,
        glowColor: widget.glowColor,
        rows: widget.dialogRows,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _c.forward(),
      onTapUp: (_) {
        _c.reverse();
        _showZoomDialog(context);
      },
      onTapCancel: () => _c.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradient,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.28),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + tap hint
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.90),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.open_in_full_rounded,
                    color: Colors.white.withOpacity(0.55),
                    size: 10.sp,
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              // Main total
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.total,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Divider
              Container(
                height: 1.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.40),
                      Colors.white.withOpacity(0.08),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              _SubLine(label: widget.line1Label, value: widget.line1Value),
              SizedBox(height: 3.h),
              _SubLine(label: widget.line2Label, value: widget.line2Value),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Zoom Bottom Sheet ─────────────────────────────────────────────────────────
class _ZoomSheet extends StatelessWidget {
  final String title;
  final String total;
  final List<Color> gradient;
  final Color glowColor;
  final List<_DialogRow> rows;

  const _ZoomSheet({
    required this.title,
    required this.total,
    required this.gradient,
    required this.glowColor,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h),
      decoration: BoxDecoration(
        color: _DS.card,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: glowColor.withOpacity(0.30), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.20),
            blurRadius: 32,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: glowColor.withOpacity(0.40),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 18.h),

          // Header card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      FittedBox(
                        child: Text(
                          total,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Detail rows
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: rows.asMap().entries.map((entry) {
                final isLast = entry.key == rows.length - 1;
                return Column(
                  children: [
                    _DetailRow(
                      row: entry.value,
                      glowColor: glowColor,
                    ),
                    if (!isLast)
                      Divider(
                        color: glowColor.withOpacity(0.10),
                        height: 1,
                        thickness: 1,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final _DialogRow row;
  final Color glowColor;
  const _DetailRow({required this.row, required this.glowColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 11.h),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: glowColor.withOpacity(0.70),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              row.label,
              style: TextStyle(
                fontSize: 13.sp,
                color: _DS.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            row.value,
            style: TextStyle(
              fontSize: 13.sp,
              color: _DS.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubLine extends StatelessWidget {
  final String label, value;
  const _SubLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 8.5.sp, color: Colors.white.withOpacity(0.80)),
        children: [
          TextSpan(
            text: '$label :- ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.5.w,
          height: 18.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_DS.cyan, _DS.cyanDim],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: _DS.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(height: 1, width: 30.w, color: _DS.border),
      ],
    );
  }
}

// ── Session Badge ─────────────────────────────────────────────────────────────
class _SessionBadge extends StatelessWidget {
  final String session;
  const _SessionBadge({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: LinearGradient(
          colors: [
            _DS.cyan.withOpacity(0.18),
            _DS.cyanDim.withOpacity(0.08),
          ],
        ),
        border: Border.all(color: _DS.cyan.withOpacity(0.35), width: 0.8),
      ),
      child: Text(
        session.isEmpty ? 'Loading...' : 'Session $session',
        style: TextStyle(
          fontSize: 9.5.sp,
          fontWeight: FontWeight.w700,
          color: _DS.cyan,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ── Icon Button (same as dashboard) ──────────────────────────────────────────
class _IconBtn extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.color, required this.onTap});

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween(begin: 1.0, end: 0.88)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _c.forward(),
      onTapUp: (_) {
        _c.reverse();
        widget.onTap();
      },
      onTapCancel: () => _c.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: widget.color.withOpacity(0.1),
            border: Border.all(color: widget.color.withOpacity(0.25), width: 1),
          ),
          child: Icon(widget.icon, color: widget.color, size: 19),
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        children: [
          Icon(Icons.insert_chart_outlined_rounded,
              color: _DS.white15, size: 52.sp),
          SizedBox(height: 14.h),
          Text(
            'No fee data available\nfor this session',
            style: TextStyle(fontSize: 13.sp, color: _DS.white40, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Error State ───────────────────────────────────────────────────────────────
class _ErrorState extends StatefulWidget {
  final String message;
  const _ErrorState({required this.message});

  @override
  State<_ErrorState> createState() => _ErrorStateState();
}

class _ErrorStateState extends State<_ErrorState>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _scale = CurvedAnimation(parent: _c, curve: Curves.elasticOut);
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _DS.bg,
      child: Center(
        child: ScaleTransition(
          scale: _scale,
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
                        width: 1.5),
                  ),
                  child: Icon(Icons.cloud_off_rounded,
                      color: const Color(0xFFFF4D4D), size: 38.sp),
                ),
                SizedBox(height: 18.h),
                Text(
                  widget.message,
                  style: TextStyle(fontSize: 13.sp, color: _DS.white40),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shimmer Skeleton ──────────────────────────────────────────────────────────
class _ShimmerSkeleton extends StatelessWidget {
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
            _ShimBox(height: 54.h, radius: 14.r),
            SizedBox(height: 14.h),
            _ShimBox(height: 90.h, radius: 18.r),
            SizedBox(height: 20.h),
            _ShimBox(height: 14.h, width: 200.w, radius: 8.r),
            SizedBox(height: 14.h),
            ...List.generate(
              3,
                  (_) => Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    _ShimBox(height: 38.h, radius: 12.r),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(child: _ShimBox(height: 100.h, radius: 16.r)),
                        SizedBox(width: 8.w),
                        Expanded(child: _ShimBox(height: 100.h, radius: 16.r)),
                        SizedBox(width: 8.w),
                        Expanded(child: _ShimBox(height: 100.h, radius: 16.r)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}