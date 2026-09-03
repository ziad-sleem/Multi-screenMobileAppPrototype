import 'package:flutter/material.dart';

class WallpaperBackground extends StatelessWidget {
  const WallpaperBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Base gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.35, 0.65, 1.0],
              colors: [Color(0xFF040410), Color(0xFF08081E), Color(0xFF060615), Color(0xFF050510)],
            ),
          ),
        ),
        // Indigo blob — top-left
        Positioned(
          top: -size.height * 0.12,
          left: -size.width * 0.15,
          child: _Blob(size.width * 0.80, size.height * 0.52, const Color(0xFF5856D6), 0.50),
        ),
        // Blue blob — bottom-right
        Positioned(
          bottom: -size.height * 0.08,
          right: -size.width * 0.15,
          child: _Blob(size.width * 0.68, size.height * 0.56, const Color(0xFF007AFF), 0.42),
        ),
        // Purple blob — top-right
        Positioned(
          top: size.height * 0.07,
          right: -size.width * 0.10,
          child: _Blob(size.width * 0.72, size.height * 0.38, const Color(0xFFAF52DE), 0.36),
        ),
        // Green blob — bottom-left
        Positioned(
          bottom: size.height * 0.10,
          left: -size.width * 0.10,
          child: _Blob(size.width * 0.48, size.height * 0.38, const Color(0xFF34C759), 0.16),
        ),
        // Center ambient glow
        Positioned(
          top: size.height * 0.38,
          left: size.width * 0.15,
          child: _Blob(size.width * 0.70, size.height * 0.28, const Color(0xFF007AFF), 0.10),
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double opacity;

  const _Blob(this.width, this.height, this.color, this.opacity);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(opacity), Colors.transparent],
          radius: 0.65,
        ),
      ),
    );
  }
}
