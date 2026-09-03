import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';
import '../widgets/avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final greeting = hour < 12 ? 'Good morning' : hour < 18 ? 'Good afternoon' : 'Good evening';
    final dateStr = _formatDate(now);
    final topPad = MediaQuery.paddingOf(context).top;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, topPad + 80, 16, 110),
      children: [
        // ── Greeting ──────────────────────────────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateStr, style: AppText.footnote.copyWith(color: AppColors.labelTertiary)),
                  const SizedBox(height: 2),
                  Text('$greeting,', style: AppText.title2),
                  ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [AppColors.systemBlue, AppColors.systemPurple],
                    ).createShader(b),
                    child: Text('Alex Johnson', style: AppText.title2.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const AppAvatar(name: 'Alex Johnson', size: 48, showStatus: true),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.systemGreen.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.systemGreen.withOpacity(0.35)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 6, height: 6,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.systemGreen,
                              boxShadow: [BoxShadow(color: AppColors.systemGreen.withOpacity(0.8), blurRadius: 5)])),
                      const SizedBox(width: 5),
                      Text('Active', style: AppText.caption2.copyWith(color: AppColors.systemGreen, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // ── Portfolio highlight card ────────────────────────────────────
        _PortfolioCard(),
        const SizedBox(height: 16),

        // ── 2×2 Stats grid ─────────────────────────────────────────────
        _StatsGrid(),
        const SizedBox(height: 16),

        // ── Recent Activity ────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Activity', style: AppText.headline),
            Text('See All', style: AppText.callout.copyWith(color: AppColors.systemBlue)),
          ],
        ),
        const SizedBox(height: 10),
        _ActivityFeed(),
        const SizedBox(height: 16),

        // ── Quick actions ─────────────────────────────────────────────
        Text('Quick Actions', style: AppText.headline),
        const SizedBox(height: 10),
        _QuickActions(),
      ],
    );
  }

  String _formatDate(DateTime d) {
    const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    return '${days[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}';
  }
}

class _PortfolioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: const LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0x595856D6), Color(0x4D007AFF), Color(0x405AC8FA)],
            ),
            border: Border.all(color: const Color(0x38FFFFFF)),
            boxShadow: [BoxShadow(color: AppColors.systemIndigo.withOpacity(0.35), blurRadius: 40, offset: const Offset(0, 8))],
          ),
          child: Stack(
            children: [
              // Sheen
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, end: Alignment.bottomCenter,
                        colors: [Colors.white.withOpacity(0.22), Colors.transparent],
                        stops: const [0.0, 0.45],
                      ),
                    ),
                  ),
                ),
              ),
              // Glow orb
              Positioned(
                top: -30, right: -30,
                child: Container(width: 140, height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(colors: [AppColors.systemBlue.withOpacity(0.20), Colors.transparent]),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Portfolio Overview', style: AppText.footnote.copyWith(color: Colors.white.withOpacity(0.65))),
                          const SizedBox(height: 4),
                          Text('\$124,850', style: AppText.largeTitle.copyWith(fontWeight: FontWeight.w700)),
                          Text('.40 USD', style: AppText.callout.copyWith(color: Colors.white.withOpacity(0.65))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.systemGreen.withOpacity(0.22),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.systemGreen.withOpacity(0.40)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.trending_up_rounded, size: 14, color: AppColors.systemGreen),
                            const SizedBox(width: 4),
                            Text('+12.4%', style: AppText.footnote.copyWith(color: AppColors.systemGreen, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('↑ \$13,820 growth this month · 3 active positions',
                      style: AppText.caption1.copyWith(color: Colors.white.withOpacity(0.50))),
                  const SizedBox(height: 16),
                  // Mini chart bars
                  SizedBox(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [40,55,45,70,60,80,65,90,75,95,85,100].asMap().entries.map((e) {
                        final last = e.key == 11;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: FractionallySizedBox(
                              heightFactor: e.value / 100,
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: last ? AppColors.systemBlue : Colors.white.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white.withOpacity(0.25)),
                          ),
                          child: Center(child: Text('View Details', style: AppText.footnote.copyWith(fontWeight: FontWeight.w600))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.systemBlue.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.systemBlue.withOpacity(0.55)),
                            boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.45), blurRadius: 16)],
                          ),
                          child: Center(child: Text('Invest Now', style: AppText.footnote.copyWith(fontWeight: FontWeight.w600))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      (label: 'Projects', value: '12', sub: '+3 this month', icon: Icons.work_outline_rounded, color: AppColors.systemBlue, up: true),
      (label: 'Tasks',    value: '48', sub: '8 due today',   icon: Icons.check_circle_outline_rounded, color: AppColors.systemPurple, up: false),
      (label: 'Score',    value: '94%', sub: '+2% this week', icon: Icons.bolt_rounded,       color: AppColors.systemGreen, up: true),
      (label: 'Hours',    value: '128h', sub: 'this month',  icon: Icons.access_time_outlined, color: AppColors.systemOrange, up: false),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.45,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: items.map((s) => GlassContainer(
        borderRadius: 24,
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Positioned(
              top: 0, right: 0,
              child: Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: s.color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: s.color.withOpacity(0.30)),
                ),
                child: Icon(s.icon, size: 16, color: s.color),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(s.value, style: AppText.title2),
                const SizedBox(height: 2),
                Text(s.label, style: AppText.footnote.copyWith(color: AppColors.labelSecondary, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (s.up) Icon(Icons.trending_up_rounded, size: 11, color: AppColors.systemGreen),
                    const SizedBox(width: 2),
                    Text(s.sub, style: AppText.caption2.copyWith(color: s.up ? AppColors.systemGreen : AppColors.labelTertiary)),
                  ],
                ),
              ],
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class _ActivityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      (icon: Icons.check_circle_outline_rounded, iconColor: AppColors.systemGreen, iconBg: AppColors.systemGreen,
       title: 'Project Alpha', sub: 'Milestone completed successfully', time: '2h ago',
       status: 'Completed', statusColor: AppColors.systemGreen),
      (icon: Icons.trending_up_rounded, iconColor: AppColors.systemBlue, iconBg: AppColors.systemBlue,
       title: 'Payment Received', sub: '\$2,450 from Acme Corp', time: '5h ago',
       status: 'Received', statusColor: AppColors.systemBlue),
      (icon: Icons.layers_outlined, iconColor: AppColors.systemPurple, iconBg: AppColors.systemPurple,
       title: 'Design Review', sub: 'Feedback session scheduled', time: 'Yesterday',
       status: 'Pending', statusColor: AppColors.systemOrange),
      (icon: Icons.bolt_rounded, iconColor: AppColors.systemTeal, iconBg: AppColors.systemTeal,
       title: 'App Deployment', sub: 'v2.3.1 deployed to production', time: '2d ago',
       status: 'Success', statusColor: AppColors.systemGreen),
    ];

    return GlassCard(
      children: items.map((item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: item.iconBg.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: item.iconBg.withOpacity(0.30)),
              ),
              child: Icon(item.icon, size: 20, color: item.iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppText.footnote.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(item.sub, style: AppText.caption1.copyWith(color: AppColors.labelTertiary), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GlassPill(label: item.status, color: item.statusColor),
                const SizedBox(height: 4),
                Text(item.time, style: AppText.caption2.copyWith(color: AppColors.labelQuaternary)),
              ],
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.labelQuaternary),
          ],
        ),
      )).toList(),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      (label: 'New Task', icon: Icons.check_circle_outline_rounded, color: AppColors.systemBlue),
      (label: 'Report',   icon: Icons.trending_up_rounded,         color: AppColors.systemPurple),
      (label: 'Schedule', icon: Icons.access_time_outlined,        color: AppColors.systemOrange),
      (label: 'Award',    icon: Icons.emoji_events_outlined,       color: AppColors.systemYellow),
    ];

    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) => GlassContainer(
          borderRadius: 24,
          width: 78,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(actions[i].icon, size: 22, color: actions[i].color),
              const SizedBox(height: 6),
              Text(actions[i].label, style: AppText.caption2.copyWith(color: Colors.white.withOpacity(0.70)), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
