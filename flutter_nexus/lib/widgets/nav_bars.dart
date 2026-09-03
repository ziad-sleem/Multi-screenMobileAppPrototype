import 'dart:ui';
import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';

// ─── Floating Top App Bar ────────────────────────────────────────────────────
class NexusTopBar extends StatelessWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const NexusTopBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    return Padding(
      padding: EdgeInsets.only(top: topPad + 8, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0x12FFFFFF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0x21FFFFFF)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.22), blurRadius: 20, offset: const Offset(0, 4)),
              ],
            ),
            child: Stack(
              children: [
                // Specular sheen
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.30, 0.60],
                          colors: [
                            Colors.white.withOpacity(0.16),
                            Colors.white.withOpacity(0.05),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      // Left
                      if (showBack)
                        GestureDetector(
                          onTap: onBack,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                              children: [
                                const Icon(Icons.chevron_left_rounded, color: AppColors.systemBlue, size: 22),
                                Text('Back', style: AppText.callout.copyWith(
                                  color: AppColors.systemBlue, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        )
                      else
                        Row(
                          children: [
                            Container(
                              width: 28, height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [AppColors.systemIndigo, AppColors.systemBlue],
                                ),
                                boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.4), blurRadius: 8)],
                              ),
                              child: const Icon(Icons.auto_awesome_rounded, size: 14, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            Text('Nexus', style: AppText.headline.copyWith(fontWeight: FontWeight.w700)),
                          ],
                        ),
                      // Center title
                      Expanded(
                        child: Center(
                          child: Text(title, style: AppText.headline),
                        ),
                      ),
                      // Right actions
                      ...(actions ??
                          [
                            _TopBarIconButton(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Icon(Icons.notifications_outlined, size: 20, color: Colors.white.withOpacity(0.80)),
                                  Positioned(
                                    top: -1, right: -1,
                                    child: Container(
                                      width: 7, height: 7,
                                      decoration: BoxDecoration(
                                        color: AppColors.systemRed,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(color: AppColors.systemRed.withOpacity(0.70), blurRadius: 5)],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            _TopBarIconButton(
                              child: Icon(Icons.search_rounded, size: 20, color: Colors.white.withOpacity(0.80)),
                            ),
                          ]),
                    ],
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

class _TopBarIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const _TopBarIconButton({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: const Color(0x0AFFFFFF),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x14FFFFFF)),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

// ─── Floating Bottom Navigation Bar ─────────────────────────────────────────
class NexusBottomNav extends StatelessWidget {
  final MainTab activeTab;
  final ValueChanged<MainTab> onTabChanged;

  const NexusBottomNav({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPad + 8, left: 16, right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0x12FFFFFF),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: const Color(0x21FFFFFF)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.24), blurRadius: 24, offset: const Offset(0, 4))],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.30, 0.60],
                          colors: [
                            Colors.white.withOpacity(0.16),
                            Colors.white.withOpacity(0.05),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    _NavTabItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home',
                        active: activeTab == MainTab.home, onTap: () => onTabChanged(MainTab.home)),
                    _NavTabItem(icon: Icons.explore_outlined, activeIcon: Icons.explore_rounded, label: 'Discover',
                        active: activeTab == MainTab.discover, onTap: () => onTabChanged(MainTab.discover)),
                    _NavTabItem(icon: Icons.access_time_outlined, activeIcon: Icons.access_time_filled_rounded, label: 'Activity',
                        active: activeTab == MainTab.activity, onTap: () => onTabChanged(MainTab.activity)),
                    _NavTabItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile',
                        active: activeTab == MainTab.profile, onTap: () => onTabChanged(MainTab.profile)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTabItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavTabItem({required this.icon, required this.activeIcon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40, height: 32,
              decoration: active
                  ? BoxDecoration(
                      color: AppColors.systemBlue.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.28), blurRadius: 12)],
                    )
                  : null,
              child: Icon(
                active ? activeIcon : icon,
                size: 22,
                color: active ? AppColors.systemBlue : Colors.white.withOpacity(0.45),
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.07,
                color: active ? AppColors.systemBlue : Colors.white.withOpacity(0.40),
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
