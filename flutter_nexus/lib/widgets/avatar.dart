import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final double size;
  final bool showStatus;
  final Color statusColor;

  const AppAvatar({
    super.key,
    required this.name,
    this.size = 44,
    this.showStatus = false,
    this.statusColor = const Color(0xFF34C759),
  });

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF5856D6), Color(0xFF007AFF), Color(0xFF5AC8FA)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF007AFF).withOpacity(0.32),
                  blurRadius: size * 0.45,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                _initials,
                style: TextStyle(
                  fontSize: size * 0.36,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          if (showStatus)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.27,
                height: size * 0.27,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black.withOpacity(0.55), width: 1.5),
                  boxShadow: [BoxShadow(color: statusColor.withOpacity(0.70), blurRadius: 6)],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
