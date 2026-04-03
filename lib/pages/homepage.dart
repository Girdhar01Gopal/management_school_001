import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/home_page_controller.dart';
import '../infrastructures/routes/page_constants.dart';

class _DS {
  static const bg       = Color(0xFF070D16);
  static const surface  = Color(0xFF0E1923);
  static const card     = Color(0xFF111D2B);
  static const border   = Color(0xFF1E3048);
  static const cyan     = Color(0xFF00E5FF);
  static const cyanDim  = Color(0xFF00B8CC);
  static const gold     = Color(0xFFFFCA28);
  static const white    = Colors.white;
  static const white70  = Color(0xB3FFFFFF);
  static const white40  = Color(0x66FFFFFF);
  static const white15  = Color(0x26FFFFFF);

  // ===== Dashboard overview card size controls =====
  static double gridChildAspectRatio = 1.94; // increase => card becomes shorter
  static double gridCrossAxisSpacing = 30;
  static double gridMainAxisSpacing = 10;
  static double gridCardPadding = 10;
}

// ─────────────────────────────────────────────────────────────────────────────
class Dhashoard extends GetView<DashboardScreenController> {
  const Dhashoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _DS.bg,
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading.value) return _ShimmerSkeleton();
        if (controller.errorMessage.value.isNotEmpty) {
          return _ErrorState(message: controller.errorMessage.value);
        }
        return _DashBody(controller: controller);
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(68.h),
      child: _GlowAppBar(
        onLogout: () async {
          final ok = await _LogoutDialog.show(context);
          if (ok == true) controller.logoutUser();
        },
        onNotification: () => Get.toNamed(
          RouteName.notification_dashboard_screen,
          arguments: {"url": controller.secUrl.value},
        ),
        onCalendar: () => Get.toNamed(
          RouteName.holiday_dashboard_screen,
          arguments: {"url": controller.secUrl.value},
        ),
        controller: controller,
      ),
    );
  }
}

// ─── Glow AppBar ─────────────────────────────────────────────────────────────
class _GlowAppBar extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onNotification;
  final VoidCallback onCalendar;
  final DashboardScreenController controller;

  const _GlowAppBar({
    required this.onLogout,
    required this.onNotification,
    required this.onCalendar,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                _IconBtn(
                  icon: Icons.logout_rounded,
                  color: const Color(0xFFFF4D4D),
                  onTap: onLogout,
                ),
                Expanded(
                  child: Obx(
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
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            color: _DS.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        _SessionBadge(session: controller.session.value),
                      ],
                    ),
                  ),
                ),
                _IconBtn(
                  icon: Icons.notifications_active_rounded,
                  color: _DS.cyan,
                  onTap: onNotification,
                ),
                SizedBox(width: 8.w),
                _IconBtn(
                  icon: Icons.calendar_month_rounded,
                  color: _DS.gold,
                  onTap: onCalendar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
        "Session $session",
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

class _IconBtn extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _IconBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

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
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOut),
    );
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
            border: Border.all(
              color: widget.color.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: Icon(widget.icon, color: widget.color, size: 19),
        ),
      ),
    );
  }
}

// ─── Body ─────────────────────────────────────────────────────────────────────
class _DashBody extends StatelessWidget {
  final DashboardScreenController controller;
  const _DashBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: _DS.cyan,
      backgroundColor: _DS.surface,
      onRefresh: controller.fetchDashboardData,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeaderBanner(),
                  SizedBox(height: 22.h),

                  // _SectionLabel(label: "Quick Stats"),
                  // SizedBox(height: 12.h),
                  // _KpiStrip(controller: controller),
                  // SizedBox(height: 26.h),

                  _SectionLabel(label: "Dashboard Overview"),
                  SizedBox(height: 14.h),
                ],
              ),
            ),
          ),
          _GridSliver(controller: controller),
          SliverToBoxAdapter(child: SizedBox(height: 28.h)),
        ],
      ),
    );
  }
}

// ─── Header Banner ────────────────────────────────────────────────────────────
class _HeaderBanner extends StatefulWidget {
  const _HeaderBanner();

  @override
  State<_HeaderBanner> createState() => _HeaderBannerState();
}

class _HeaderBannerState extends State<_HeaderBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _fade, _slide;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _c, curve: Curves.easeOut);
    _slide = Tween(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOutCubic),
    );
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, child) => Opacity(
        opacity: _fade.value,
        child: Transform.translate(offset: Offset(0, _slide.value), child: child),
      ),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _DS.cyan.withOpacity(0.12),
              _DS.cyanDim.withOpacity(0.04),
            ],
          ),
          border: Border.all(color: _DS.cyan.withOpacity(0.22), width: 1),
          boxShadow: [
            BoxShadow(
              color: _DS.cyan.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            _RingAvatar(),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome school 👋",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: _DS.cyan,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "Your school is running great today.",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: _DS.white40,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            _LiveDot(),
          ],
        ),
      ),
    );
  }
}

class _RingAvatar extends StatefulWidget {
  @override
  State<_RingAvatar> createState() => _RingAvatarState();
}

class _RingAvatarState extends State<_RingAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => CustomPaint(
        painter: _RingPainter(progress: _c.value),
        child: Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                _DS.cyan.withOpacity(0.25),
                _DS.cyanDim.withOpacity(0.1),
              ],
            ),
          ),
          child: Icon(Icons.school_rounded, color: _DS.cyan, size: 22.sp),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _DS.cyan.withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;
    canvas.drawArc(
      rect.deflate(2),
      -math.pi / 2 + progress * 2 * math.pi,
      math.pi * 1.2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}

// ─── Live Dot ─────────────────────────────────────────────────────────────────
class _LiveDot extends StatefulWidget {
  @override
  State<_LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<_LiveDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.8 + _c.value * 0.5,
            child: Opacity(
              opacity: 0.4 + _c.value * 0.6,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF69F0AE),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF69F0AE).withOpacity(0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "LIVE",
            style: TextStyle(
              fontSize: 8.sp,
              color: const Color(0xFF69F0AE),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────
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
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
            color: _DS.white,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(child: Container(height: 1, color: _DS.border)),
      ],
    );
  }
}

// ─── KPI Strip ────────────────────────────────────────────────────────────────
class _KpiStrip extends StatelessWidget {
  final DashboardScreenController controller;
  const _KpiStrip({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.filteredList.take(4).toList();
      if (items.isEmpty) return const SizedBox.shrink();

      return SizedBox(
        height: 112.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (context, i) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 350 + i * 100),
              curve: Curves.easeOutBack,
              builder: (_, v, child) => Transform.scale(
                scale: v,
                child: Opacity(
                  opacity: v.clamp(0.0, 1.0),
                  child: child,
                ),
              ),
              child: _KpiCard(item: items[i]),
            );
          },
        ),
      );
    });
  }
}

class _KpiCard extends StatefulWidget {
  final dynamic item;
  const _KpiCard({required this.item});

  @override
  State<_KpiCard> createState() => _KpiCardState();
}

class _KpiCardState extends State<_KpiCard>
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
    _scale = Tween(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final List<Color> grad =
        item.gradientColors ?? [item.color.withOpacity(0.85), item.color];

    return GestureDetector(
      onTapDown: (_) => _c.forward(),
      onTapUp: (_) => _c.reverse(),
      onTapCancel: () => _c.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 148.w,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: grad,
            ),
            boxShadow: [
              BoxShadow(
                color: item.color.withOpacity(0.45),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(item.image, color: Colors.white, size: 14.sp),
                  ),
                  SizedBox(width: 7.w),
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white.withOpacity(0.92),
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: _CountUp(
                  target: int.tryParse(item.count) ?? 0,
                  style: TextStyle(
                    fontSize: 26.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    height: 1.0,
                  ),
                ),
              ),
              Container(
                height: 2.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.12),
                      Colors.white.withOpacity(0.55),
                      Colors.white.withOpacity(0.12),
                    ],
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

// ─── Grid Sliver ──────────────────────────────────────────────────────────────
class _GridSliver extends StatelessWidget {
  final DashboardScreenController controller;
  const _GridSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.filteredList.isEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Column(
              children: [
                Icon(Icons.dashboard_outlined, color: _DS.white15, size: 48.sp),
                SizedBox(height: 12.h),
                Text(
                  "No items found",
                  style: TextStyle(fontSize: 13.sp, color: _DS.white40),
                ),
              ],
            ),
          ),
        );
      }

      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: _DS.gridChildAspectRatio,
            crossAxisSpacing: _DS.gridCrossAxisSpacing.w,
            mainAxisSpacing: _DS.gridMainAxisSpacing.h,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, i) {
              final item = controller.filteredList[i];
              return AnimationConfiguration.staggeredGrid(
                position: i,
                duration: const Duration(milliseconds: 550),
                columnCount: 2,
                child: ScaleAnimation(
                  scale: 0.82,
                  child: FadeInAnimation(
                    child: _GridCard(
                      item: item,
                      onTap: () => controller.onSelectedBottom(i),
                    ),
                  ),
                ),
              );
            },
            childCount: controller.filteredList.length,
          ),
        ),
      );
    });
  }
}

// ─── Grid Card ────────────────────────────────────────────────────────────────
class _GridCard extends StatefulWidget {
  final dynamic item;
  final VoidCallback onTap;
  const _GridCard({required this.item, required this.onTap});

  @override
  State<_GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<_GridCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _scale;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scale = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final List<Color> grad =
        item.gradientColors ?? [item.color.withOpacity(0.85), item.color];

    return GestureDetector(
      onTapDown: (_) {
        _c.forward();
        setState(() => _pressed = true);
      },
      onTapUp: (_) {
        _c.reverse();
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () {
        _c.reverse();
        setState(() => _pressed = false);
      },
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: _DS.gridCardPadding.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: grad,
            ),
            boxShadow: [
              BoxShadow(
                color: item.color.withOpacity(_pressed ? 0.35 : 0.22),
                blurRadius: _pressed ? 20 : 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // top row: icon + name
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      item.image,
                      color: Colors.white,
                      size: 30.sp, // ❌ same as before (NO change)
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp, // ✅ text bigger
                        color: Colors.white.withOpacity(0.92),
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ],
              ),

              // center count
              Center(
                child: _CountUp(
                  target: int.tryParse(item.count) ?? 0,
                  style: TextStyle(
                    fontSize: 24.sp, // ✅ count bigger
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    height: 1.0,
                  ),
                ),
              ),

              // bottom line
              Container(
                height: 2.5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.12),
                      Colors.white.withOpacity(0.55),
                      Colors.white.withOpacity(0.12),
                    ],
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

// ─── Count-Up ────────────────────────────────────────────────────────────────
class _CountUp extends StatefulWidget {
  final int target;
  final TextStyle style;
  const _CountUp({required this.target, required this.style});

  @override
  State<_CountUp> createState() => _CountUpState();
}

class _CountUpState extends State<_CountUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _anim = Tween<double>(begin: 0, end: widget.target.toDouble()).animate(
      CurvedAnimation(parent: _c, curve: Curves.easeOutCubic),
    );
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final val = _anim.value
            .toInt()
            .toString()
            .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
        return Text(val, style: widget.style);
      },
    );
  }
}

// ─── Shimmer Skeleton ─────────────────────────────────────────────────────────
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
            _ShimBox(height: 72.h, radius: 20.r),
            SizedBox(height: 22.h),

            // _ShimBox(height: 14.h, width: 100.w, radius: 8.r),
            // SizedBox(height: 12.h),
            // SizedBox(
            //   height: 112.h,
            //   child: Row(
            //     children: List.generate(
            //       3,
            //       (i) => Padding(
            //         padding: EdgeInsets.only(right: 10.w),
            //         child: _ShimBox(width: 148.w, height: 112.h, radius: 18.r),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 26.h),

            _ShimBox(height: 14.h, width: 140.w, radius: 8.r),
            SizedBox(height: 14.h),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: _DS.gridChildAspectRatio,
                  crossAxisSpacing: _DS.gridCrossAxisSpacing.w,
                  mainAxisSpacing: _DS.gridMainAxisSpacing.h,
                ),
                itemBuilder: (_, __) => _ShimBox(radius: 18.r),
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

// ─── Error State ──────────────────────────────────────────────────────────────
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
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
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
                  widget.message,
                  style: TextStyle(fontSize: 14.sp, color: _DS.white40),
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

// ─── Logout Dialog ────────────────────────────────────────────────────────────
class _LogoutDialog {
  static Future<bool?> show(BuildContext context) {
    return Get.dialog<bool>(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF142030), Color(0xFF0A151F)],
            ),
            borderRadius: BorderRadius.circular(26.r),
            border: Border.all(color: _DS.cyan.withOpacity(0.18), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF4D4D).withOpacity(0.1),
                  border: Border.all(
                    color: const Color(0xFFFF4D4D).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: const Color(0xFFFF4D4D),
                  size: 28.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  color: _DS.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Are you sure you want to logout?",
                style: TextStyle(fontSize: 12.5.sp, color: _DS.white40),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(result: false),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          side: BorderSide(color: _DS.white15, width: 1),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: _DS.white70,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF4D4D), Color(0xFFCC2E2E)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF4D4D).withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () => Get.back(result: true),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}