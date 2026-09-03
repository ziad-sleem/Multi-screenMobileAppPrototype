import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _filter = 'All';

  static const _filters = ['All', 'Transactions', 'Projects', 'System'];

  final _groups = [
    (
      date: 'Today',
      items: [
        (icon: Icons.check_circle_outline_rounded, iColor: AppColors.systemGreen,
         title: 'Project Alpha — Milestone 3', sub: 'All deliverables approved by stakeholders',
         time: '2:14 PM', type: 'Projects', status: 'Completed', sColor: AppColors.systemGreen),
        (icon: Icons.trending_up_rounded, iColor: AppColors.systemBlue,
         title: 'Payment Received', sub: '\$2,450.00 from Acme Corp',
         time: '10:32 AM', type: 'Transactions', status: 'Received', sColor: AppColors.systemBlue),
        (icon: Icons.emoji_events_outlined, iColor: AppColors.systemYellow,
         title: 'Achievement Unlocked', sub: '100 tasks completed this quarter',
         time: '9:05 AM', type: 'System', status: 'New', sColor: AppColors.systemYellow),
      ],
    ),
    (
      date: 'Yesterday',
      items: [
        (icon: Icons.layers_outlined, iColor: AppColors.systemPurple,
         title: 'Design System v3', sub: 'Component library published',
         time: '4:45 PM', type: 'Projects', status: 'Published', sColor: AppColors.systemPurple),
        (icon: Icons.bolt_rounded, iColor: AppColors.systemTeal,
         title: 'App Deployment', sub: 'v2.3.1 deployed to production',
         time: '2:30 PM', type: 'System', status: 'Success', sColor: AppColors.systemGreen),
        (icon: Icons.trending_up_rounded, iColor: AppColors.systemOrange,
         title: 'Invoice Sent', sub: '\$5,800 to GlobalTech Solutions',
         time: '11:15 AM', type: 'Transactions', status: 'Pending', sColor: AppColors.systemOrange),
      ],
    ),
    (
      date: 'Sep 1',
      items: [
        (icon: Icons.work_outline_rounded, iColor: AppColors.systemIndigo,
         title: 'New Project Started', sub: 'Beta Platform Redesign — Q4 2026',
         time: '3:20 PM', type: 'Projects', status: 'Active', sColor: AppColors.systemBlue),
        (icon: Icons.access_time_outlined, iColor: AppColors.systemGray,
         title: 'Weekly Review', sub: 'Completed 34 tasks, 8h logged',
         time: '9:00 AM', type: 'System', status: 'Done', sColor: AppColors.systemGreen),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, topPad + 80, 16, 110),
      children: [
        // Filter pills
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final active = _filter == _filters[i];
              return GestureDetector(
                onTap: () => setState(() => _filter = _filters[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: active ? AppColors.systemBlue.withOpacity(0.22) : const Color(0x12FFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: active ? AppColors.systemBlue.withOpacity(0.50) : const Color(0x1FFFFFFF)),
                    boxShadow: active ? [BoxShadow(color: AppColors.systemBlue.withOpacity(0.25), blurRadius: 12)] : null,
                  ),
                  child: Text(_filters[i], style: AppText.footnote.copyWith(
                    color: active ? AppColors.systemBlue : Colors.white.withOpacity(0.55),
                    fontWeight: FontWeight.w500,
                  )),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // Summary stats
        Row(
          children: [
            _StatTile(label: 'This Week', value: '24', sub: 'events', color: AppColors.systemBlue),
            const SizedBox(width: 10),
            _StatTile(label: 'Revenue', value: '\$8.2k', sub: 'received', color: AppColors.systemGreen),
            const SizedBox(width: 10),
            _StatTile(label: 'Streak', value: '14d', sub: 'active', color: AppColors.systemOrange),
          ],
        ),
        const SizedBox(height: 16),

        // Timeline groups
        ..._groups.expand((group) {
          final filtered = group.items.where((item) => _filter == 'All' || item.type == _filter).toList();
          if (filtered.isEmpty) return <Widget>[];

          return [
            Row(
              children: [
                Text(group.date, style: AppText.footnote.copyWith(color: AppColors.labelSecondary, fontWeight: FontWeight.w600)),
                const SizedBox(width: 12),
                Expanded(child: Container(height: 0.5, color: AppColors.separator)),
                const SizedBox(width: 10),
                Text('${filtered.length} events', style: AppText.caption2.copyWith(color: AppColors.labelQuaternary)),
              ],
            ),
            const SizedBox(height: 8),
            GlassCard(
              children: filtered.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: item.iColor.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: item.iColor.withOpacity(0.30)),
                      ),
                      child: Icon(item.icon, size: 20, color: item.iColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: AppText.footnote.copyWith(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 2),
                          Text(item.sub, style: AppText.caption1.copyWith(color: AppColors.labelTertiary), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GlassPill(label: item.status, color: item.sColor),
                        const SizedBox(height: 4),
                        Text(item.time, style: AppText.caption2.copyWith(color: AppColors.labelQuaternary)),
                      ],
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.labelQuaternary),
                  ],
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
          ];
        }),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final Color color;
  const _StatTile({required this.label, required this.value, required this.sub, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassContainer(
        borderRadius: 16,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: [
            Text(value, style: AppText.title3.copyWith(fontWeight: FontWeight.w700)),
            Text(sub, style: AppText.caption2.copyWith(color: color)),
            Text(label, style: AppText.caption2.copyWith(color: AppColors.labelTertiary)),
          ],
        ),
      ),
    );
  }
}
