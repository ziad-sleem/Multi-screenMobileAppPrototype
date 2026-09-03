import 'package:flutter/material.dart';

// ─── iOS 27 System Colors ───────────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const Color systemBlue    = Color(0xFF007AFF);
  static const Color systemIndigo  = Color(0xFF5856D6);
  static const Color systemPurple  = Color(0xFFAF52DE);
  static const Color systemGreen   = Color(0xFF34C759);
  static const Color systemTeal    = Color(0xFF5AC8FA);
  static const Color systemOrange  = Color(0xFFFF9500);
  static const Color systemYellow  = Color(0xFFFFD60A);
  static const Color systemRed     = Color(0xFFFF3B30);
  static const Color systemGray    = Color(0xFF8E8E93);
  static const Color systemGray2   = Color(0xFF636366);
  static const Color systemGray3   = Color(0xFF48484A);
  static const Color systemGray4   = Color(0xFF3A3A3C);
  static const Color systemGray5   = Color(0xFF2C2C2E);
  static const Color systemGray6   = Color(0xFF1C1C1E);

  // Semantic labels (dark mode)
  static const Color label           = Colors.white;
  static const Color labelSecondary  = Color(0x99FFFFFF); // 60%
  static const Color labelTertiary   = Color(0x59FFFFFF); // 35%
  static const Color labelQuaternary = Color(0x2EFFFFFF); // 18%
  static const Color separator       = Color(0x1FFFFFFF); // 12%
  static const Color fill            = Color(0x14FFFFFF); //  8%

  // Glass material tints
  static const Color glassUltraThin = Color(0x0AFFFFFF); //  4%
  static const Color glassThin      = Color(0x12FFFFFF); //  7%
  static const Color glassRegular   = Color(0x1AFFFFFF); // 10%
  static const Color glassThick     = Color(0x26FFFFFF); // 15%

  // Wallpaper
  static const Color bgBase = Color(0xFF040410);
}

// ─── iOS Typography Scale ────────────────────────────────────────────────────
class AppText {
  AppText._();

  // System font — SF Pro on iOS, Roboto on Android (no fontFamily needed)
  static const TextStyle largeTitle = TextStyle(fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -0.41, height: 1.18, color: AppColors.label);
  static const TextStyle title1     = TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.30, height: 1.22, color: AppColors.label);
  static const TextStyle title2     = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.26, height: 1.27, color: AppColors.label);
  static const TextStyle title3     = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.45, height: 1.30, color: AppColors.label);
  static const TextStyle headline   = TextStyle(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.41, height: 1.35, color: AppColors.label);
  static const TextStyle body       = TextStyle(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -0.41, height: 1.47, color: AppColors.label);
  static const TextStyle callout    = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: -0.32, height: 1.50, color: AppColors.label);
  static const TextStyle subhead    = TextStyle(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -0.23, height: 1.47, color: AppColors.label);
  static const TextStyle footnote   = TextStyle(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: -0.08, height: 1.54, color: AppColors.label);
  static const TextStyle caption1   = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing:  0.00, height: 1.50, color: AppColors.label);
  static const TextStyle caption2   = TextStyle(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing:  0.07, height: 1.45, color: AppColors.label);
}
