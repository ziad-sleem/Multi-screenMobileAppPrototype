import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';
import '../widgets/avatar.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onEditProfile, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return ListView(
      padding: EdgeInsets.fromLTRB(16, topPad + 80, 16, 110),
      children: [
        // Profile hero card
        _ProfileHero(onEditProfile: onEditProfile),
        const SizedBox(height: 20),

        // Account Settings
        _SectionHeader('Account Settings'),
        const SizedBox(height: 8),
        GlassCard(children: [
          _SettingRow(icon: Icons.settings_outlined, iconColor: AppColors.systemBlue,
              iconBg: AppColors.systemBlue, label: 'Personal Info', sub: 'Name, email, location'),
          _SettingRow(icon: Icons.shield_outlined, iconColor: AppColors.systemGreen,
              iconBg: AppColors.systemGreen, label: 'Security & Password', sub: 'Two-factor, biometrics'),
          _SettingRow(icon: Icons.link_rounded, iconColor: AppColors.systemPurple,
              iconBg: AppColors.systemPurple, label: 'Linked Accounts', sub: 'Google, Apple, GitHub'),
        ]),
        const SizedBox(height: 16),

        // Preferences
        _SectionHeader('Preferences'),
        const SizedBox(height: 8),
        GlassCard(children: [
          _SettingRow(icon: Icons.notifications_outlined, iconColor: AppColors.systemOrange,
              iconBg: AppColors.systemOrange, label: 'Push Notifications', sub: 'Alerts, reminders, updates',
              trailing: _Toggle(value: true)),
          _SettingRow(icon: Icons.language_rounded, iconColor: AppColors.systemTeal,
              iconBg: AppColors.systemTeal, label: 'App Language', sub: 'English (US)'),
          _SettingRow(icon: Icons.lock_outline_rounded, iconColor: AppColors.systemIndigo,
              iconBg: AppColors.systemIndigo, label: 'Privacy Controls', sub: 'Data sharing, visibility'),
        ]),
        const SizedBox(height: 16),

        // System & Support
        _SectionHeader('System & Support'),
        const SizedBox(height: 8),
        GlassCard(children: [
          _SettingRow(icon: Icons.help_outline_rounded, iconColor: AppColors.systemBlue,
              iconBg: AppColors.systemBlue, label: 'Help Center', sub: 'Guides, FAQs, contact'),
          _SettingRow(icon: Icons.description_outlined, iconColor: AppColors.systemGray,
              iconBg: AppColors.systemGray, label: 'Terms of Service', sub: 'Legal & privacy'),
          _SettingRow(icon: Icons.delete_outline_rounded, iconColor: AppColors.systemOrange,
              iconBg: AppColors.systemOrange, label: 'Clear Cache', sub: 'Frees up 24.6 MB'),
        ]),
        const SizedBox(height: 16),

        // Sign Out
        GlassCard(children: [
          _SettingRow(
            icon: Icons.logout_rounded,
            iconColor: AppColors.systemRed,
            iconBg: AppColors.systemRed,
            label: 'Sign Out',
            danger: true,
            trailing: const SizedBox(),
            onTap: onLogout,
          ),
        ]),
        const SizedBox(height: 16),

        Center(child: Text('Nexus v2.3.1 · Build 2026.09.02',
            style: AppText.caption2.copyWith(color: AppColors.labelQuaternary))),
      ],
    );
  }
}

class _ProfileHero extends StatelessWidget {
  final VoidCallback onEditProfile;
  const _ProfileHero({required this.onEditProfile});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0x1AFFFFFF),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0x2BFFFFFF)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.28), blurRadius: 32, offset: const Offset(0, 8))],
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
              // Glow
              Positioned(
                top: -20, right: -20,
                child: Container(width: 100, height: 100,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [AppColors.systemIndigo.withOpacity(0.18), Colors.transparent]))),
              ),
              Column(
                children: [
                  const AppAvatar(name: 'Alex Johnson', size: 80, showStatus: true),
                  const SizedBox(height: 12),
                  Text('Alex Johnson', style: AppText.title2.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text('@alexjohnson', style: AppText.callout.copyWith(color: AppColors.labelSecondary)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.systemBlue.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.systemBlue.withOpacity(0.40)),
                    ),
                    child: Text('Senior Product Designer',
                        style: AppText.caption2.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 18),
                  // Stats row
                  Row(
                    children: [
                      _ProfileStat(value: '12',  label: 'Projects',       icon: Icons.work_outline_rounded,       color: AppColors.systemBlue),
                      _Divider(),
                      _ProfileStat(value: '94',  label: 'Activity Score', icon: Icons.bolt_rounded,               color: AppColors.systemGreen),
                      _Divider(),
                      _ProfileStat(value: 'Pro', label: 'Membership',     icon: Icons.emoji_events_outlined,      color: AppColors.systemYellow),
                    ],
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: onEditProfile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.systemBlue.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.systemBlue.withOpacity(0.45)),
                        boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.28), blurRadius: 16)],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit_outlined, size: 16, color: AppColors.systemBlue),
                          const SizedBox(width: 6),
                          Text('Edit Profile', style: AppText.callout.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
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

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  const _ProfileStat({required this.value, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppText.title3.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(label, style: AppText.caption2.copyWith(color: AppColors.labelTertiary)),
          const SizedBox(height: 3),
          Icon(icon, size: 12, color: color),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 0.5, height: 40, color: AppColors.separator);
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: AppText.caption2.copyWith(color: Colors.white.withOpacity(0.40), fontWeight: FontWeight.w600, letterSpacing: 0.8),
  );
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String? sub;
  final bool danger;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    this.sub,
    this.danger = false,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: iconBg.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: iconBg.withOpacity(0.28)),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppText.callout.copyWith(
                      fontWeight: FontWeight.w500,
                      color: danger ? AppColors.systemRed : AppColors.label)),
                  if (sub != null)
                    Text(sub!, style: AppText.caption1.copyWith(color: AppColors.labelTertiary)),
                ],
              ),
            ),
            trailing ?? Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.labelQuaternary),
          ],
        ),
      ),
    );
  }
}

class _Toggle extends StatefulWidget {
  final bool value;
  const _Toggle({required this.value});

  @override
  State<_Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<_Toggle> {
  late bool _on;

  @override
  void initState() { super.initState(); _on = widget.value; }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44, height: 26,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: _on ? AppColors.systemGreen : Colors.white.withOpacity(0.20),
          boxShadow: _on ? [BoxShadow(color: AppColors.systemGreen.withOpacity(0.40), blurRadius: 8)] : null,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: _on ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22, height: 22,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
          ),
        ),
      ),
    );
  }
}
