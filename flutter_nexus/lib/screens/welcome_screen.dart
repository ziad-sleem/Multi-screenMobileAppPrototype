import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onSignIn;

  const WelcomeScreen({super.key, required this.onGetStarted, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Spacer(flex: 1),
          // Hero illustration
          _HeroIllustration(),
          const Spacer(flex: 1),
          // Headline
          Column(
            children: [
              Text('Your Life,', style: AppText.largeTitle),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.systemBlue, AppColors.systemPurple],
                ).createShader(bounds),
                child: Text('Elevated', style: AppText.largeTitle.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 12),
              Text(
                'One intelligent workspace to manage\nprojects, track progress, and connect\nwith what matters.',
                textAlign: TextAlign.center,
                style: AppText.callout.copyWith(color: AppColors.labelSecondary, height: 1.55),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Feature chips
          Wrap(
            spacing: 10,
            children: ['Dashboard', 'Analytics', 'Teams', 'Secure'].map((f) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0x0AFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x14FFFFFF)),
              ),
              child: Text(f, style: AppText.caption1.copyWith(color: AppColors.labelTertiary)),
            )).toList(),
          ),
          const SizedBox(height: 32),
          // CTAs
          GlassPrimaryButton(
            label: 'Get Started',
            icon: Icons.auto_awesome_rounded,
            onPressed: onGetStarted,
          ),
          const SizedBox(height: 12),
          GlassContainer(
            material: GlassMaterial.thin,
            borderRadius: 20,
            height: 56,
            child: GestureDetector(
              onTap: onGetStarted,
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: Text('Create Account', style: AppText.headline.copyWith(color: Colors.white.withOpacity(0.80))),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onSignIn,
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: AppText.callout.copyWith(color: AppColors.labelSecondary),
                children: [
                  TextSpan(text: 'Log In', style: TextStyle(color: AppColors.systemBlue, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _HeroIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.systemIndigo.withOpacity(0.30), Colors.transparent],
                radius: 0.7,
              ),
            ),
          ),
          // Outer ring — ultra-thin glass
          _GlassRing(280, 280, 0.04, 28),
          // Middle ring — thin glass
          _GlassRing(210, 210, 0.07, 32),
          // Inner ring — regular glass
          _GlassRing(140, 140, 0.12, 36),
          // Core orb
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                center: Alignment(-0.3, -0.3),
                colors: [Color(0xCC5856D6), Color(0xCC007AFF)],
              ),
              boxShadow: [
                BoxShadow(color: AppColors.systemIndigo.withOpacity(0.55), blurRadius: 32),
                BoxShadow(color: Colors.white.withOpacity(0.35), blurRadius: 0, spreadRadius: 0, offset: const Offset(-2, -2)),
              ],
            ),
            child: const Icon(Icons.auto_awesome_rounded, size: 32, color: Colors.white),
          ),
          // Floating accent orbs
          ..._floatingOrbs(),
          // AI-Powered badge
          Positioned(
            top: 18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0x2BFFFFFF)),
                    boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.3), blurRadius: 16)],
                  ),
                  child: Text('✦ AI-Powered', style: AppText.caption1.copyWith(color: Colors.white.withOpacity(0.80), fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ),
          // Live badge
          Positioned(
            bottom: 20,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.systemGreen.withOpacity(0.35)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6, height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.systemGreen,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: AppColors.systemGreen.withOpacity(0.8), blurRadius: 4)],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text('Live', style: AppText.caption2.copyWith(color: AppColors.systemGreen, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _floatingOrbs() {
    final orbs = [
      (top: 16.0, left: 22.0, size: 36.0, color: AppColors.systemPurple, opacity: 0.18),
      (top: 20.0, right: 18.0, size: 32.0, color: AppColors.systemTeal, opacity: 0.18),
      (bottom: 22.0, left: 18.0, size: 30.0, color: AppColors.systemGreen, opacity: 0.15),
      (bottom: 28.0, right: 22.0, size: 34.0, color: AppColors.systemOrange, opacity: 0.16),
    ];

    return orbs.map((o) {
      Widget w = ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            width: o.size, height: o.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: o.color.withOpacity(o.opacity * 1.5),
              border: Border.all(color: o.color.withOpacity(0.25)),
              boxShadow: [BoxShadow(color: o.color.withOpacity(0.3), blurRadius: 12)],
            ),
          ),
        ),
      );
      return Positioned(
        top: (o as dynamic).top as double?,
        left: (o as dynamic).left as double?,
        right: (o as dynamic).right as double?,
        bottom: (o as dynamic).bottom as double?,
        child: w,
      );
    }).toList();
  }
}

class _GlassRing extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;
  final double blur;
  const _GlassRing(this.width, this.height, this.opacity, this.blur);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(opacity),
            border: Border.all(color: Colors.white.withOpacity(opacity * 2.5), width: 1),
          ),
        ),
      ),
    );
  }
}
