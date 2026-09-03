import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _category = 'Design';

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    final categories = [
      (label: 'Design',    color: AppColors.systemPurple),
      (label: 'Dev',       color: AppColors.systemBlue),
      (label: 'Analytics', color: AppColors.systemTeal),
      (label: 'Finance',   color: AppColors.systemGreen),
      (label: 'Marketing', color: AppColors.systemOrange),
    ];

    final featured = [
      (name: 'Nexus AI',   desc: 'Intelligent task automation', icon: Icons.bolt_rounded,              color: AppColors.systemBlue,   rating: '4.9', users: '24k'),
      (name: 'FlowBoard',  desc: 'Visual project management',   icon: Icons.grid_view_rounded,         color: AppColors.systemPurple, rating: '4.8', users: '18k'),
      (name: 'DataPulse',  desc: 'Real-time analytics',         icon: Icons.trending_up_rounded,       color: AppColors.systemGreen,  rating: '4.7', users: '31k'),
      (name: 'WorkSpace+', desc: 'Team collaboration suite',    icon: Icons.workspaces_outline_rounded, color: AppColors.systemOrange, rating: '4.6', users: '15k'),
    ];

    final trending = [
      (name: 'Workspace Pro', icon: Icons.work_outline_rounded,      color: AppColors.systemOrange, tag: 'New',      users: '5.2k'),
      (name: 'LayerStack',    icon: Icons.layers_outlined,            color: AppColors.systemIndigo, tag: 'Popular',  users: '12k'),
      (name: 'StarTrack',     icon: Icons.star_outline_rounded,       color: AppColors.systemYellow, tag: 'Trending', users: '9.8k'),
      (name: 'ZapFlow',       icon: Icons.bolt_rounded,               color: AppColors.systemTeal,   tag: 'Hot',      users: '7.3k'),
    ];

    return ListView(
      padding: EdgeInsets.fromLTRB(16, topPad + 80, 16, 110),
      children: [
        // Search
        GlassTextField(placeholder: 'Search tools, templates, integrations…', leadingIcon: Icons.search_rounded),
        const SizedBox(height: 16),

        // Category pills
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final cat = categories[i];
              final active = _category == cat.label;
              return GestureDetector(
                onTap: () => setState(() => _category = cat.label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: active ? cat.color.withOpacity(0.22) : const Color(0x12FFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: active ? cat.color.withOpacity(0.50) : const Color(0x1FFFFFFF)),
                    boxShadow: active ? [BoxShadow(color: cat.color.withOpacity(0.28), blurRadius: 12)] : null,
                  ),
                  child: Text(cat.label,
                      style: AppText.footnote.copyWith(
                        color: active ? cat.color : Colors.white.withOpacity(0.55),
                        fontWeight: FontWeight.w500,
                      )),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // Featured
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Featured', style: AppText.headline),
            Text('See All', style: AppText.callout.copyWith(color: AppColors.systemBlue)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 172,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: featured.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final item = featured[i];
              return GlassContainer(
                borderRadius: 24,
                width: 190,
                padding: const EdgeInsets.all(16),
                tintColor: item.color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: item.color.withOpacity(0.40)),
                        boxShadow: [BoxShadow(color: item.color.withOpacity(0.30), blurRadius: 16)],
                      ),
                      child: Icon(item.icon, size: 22, color: item.color),
                    ),
                    const SizedBox(height: 10),
                    Text(item.name, style: AppText.footnote.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 3),
                    Expanded(
                      child: Text(item.desc, style: AppText.caption1.copyWith(color: AppColors.labelTertiary), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(Icons.star_rounded, size: 12, color: AppColors.systemYellow),
                          const SizedBox(width: 3),
                          Text(item.rating, style: AppText.caption2.copyWith(fontWeight: FontWeight.w600)),
                        ]),
                        Text('${item.users} users', style: AppText.caption2.copyWith(color: AppColors.labelTertiary)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // Trending
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Trending Now', style: AppText.headline),
            Icon(Icons.trending_up_rounded, size: 18, color: AppColors.systemOrange),
          ],
        ),
        const SizedBox(height: 10),
        GlassCard(
          children: trending.map((item) {
            final tagColor = switch (item.tag) {
              'New'  => AppColors.systemGreen,
              'Hot'  => AppColors.systemRed,
              _      => AppColors.systemBlue,
            };
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: item.color.withOpacity(0.30)),
                    ),
                    child: Icon(item.icon, size: 20, color: item.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: AppText.footnote.copyWith(fontWeight: FontWeight.w600)),
                      Text('${item.users} active users', style: AppText.caption2.copyWith(color: AppColors.labelTertiary)),
                    ],
                  )),
                  GlassPill(label: item.tag, color: tagColor),
                  const SizedBox(width: 6),
                  Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.labelQuaternary),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Collections
        Text('Collections', style: AppText.headline),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            (name: 'Starter Pack',    items: '12 tools', color: AppColors.systemBlue),
            (name: 'Pro Bundle',      items: '28 tools', color: AppColors.systemPurple),
            (name: 'Analytics Suite', items: '9 tools',  color: AppColors.systemGreen),
            (name: 'Creative Kit',    items: '15 tools', color: AppColors.systemOrange),
          ].map((col) => GlassContainer(
            borderRadius: 20,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(col.name, style: AppText.footnote.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(col.items, style: AppText.caption2.copyWith(color: AppColors.labelTertiary)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: 0.6,
                    minHeight: 3,
                    backgroundColor: col.color.withOpacity(0.20),
                    valueColor: AlwaysStoppedAnimation(col.color),
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ],
    );
  }
}
