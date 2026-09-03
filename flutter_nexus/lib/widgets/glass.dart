import 'dart:ui';
import 'package:flutter/material.dart';

enum GlassMaterial { ultraThin, thin, regular, thick }

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final GlassMaterial material;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? tintColor;
  final bool showSheen;
  final BoxBorder? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.material = GlassMaterial.regular,
    this.padding,
    this.width,
    this.height,
    this.tintColor,
    this.showSheen = true,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final spec = _spec(material);
    final baseColor = tintColor != null
        ? Color.alphaBlend(tintColor!.withOpacity(0.22), spec.color)
        : spec.color;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: spec.blur, sigmaY: spec.blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border ?? Border.all(color: spec.borderColor, width: 1),
            boxShadow: spec.shadows,
          ),
          child: showSheen ? _withSheen(child, borderRadius, spec.sheenOpacity) : child,
        ),
      ),
    );
  }

  static Widget _withSheen(Widget child, double br, double opacity) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(br),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.28, 0.58],
                  colors: [
                    Colors.white.withOpacity(opacity),
                    Colors.white.withOpacity(opacity * 0.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _GlassSpec {
  final Color color;
  final double blur;
  final Color borderColor;
  final List<BoxShadow> shadows;
  final double sheenOpacity;

  const _GlassSpec({
    required this.color,
    required this.blur,
    required this.borderColor,
    required this.shadows,
    required this.sheenOpacity,
  });
}

_GlassSpec _spec(GlassMaterial m) => switch (m) {
  GlassMaterial.ultraThin => _GlassSpec(
    color: const Color(0x0AFFFFFF),
    blur: 20,
    borderColor: const Color(0x14FFFFFF),
    shadows: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8, offset: const Offset(0, 2))],
    sheenOpacity: 0.10,
  ),
  GlassMaterial.thin => _GlassSpec(
    color: const Color(0x12FFFFFF),
    blur: 28,
    borderColor: const Color(0x21FFFFFF),
    shadows: [
      BoxShadow(color: Colors.black.withOpacity(0.22), blurRadius: 20, offset: const Offset(0, 4)),
      BoxShadow(color: Colors.white.withOpacity(0.06), blurRadius: 0, spreadRadius: 0, offset: const Offset(0, 1)),
    ],
    sheenOpacity: 0.16,
  ),
  GlassMaterial.regular => _GlassSpec(
    color: const Color(0x1AFFFFFF),
    blur: 32,
    borderColor: const Color(0x2BFFFFFF),
    shadows: [
      BoxShadow(color: Colors.black.withOpacity(0.28), blurRadius: 32, offset: const Offset(0, 8)),
      BoxShadow(color: Colors.white.withOpacity(0.07), blurRadius: 0, spreadRadius: 0, offset: const Offset(0, 1)),
    ],
    sheenOpacity: 0.20,
  ),
  GlassMaterial.thick => _GlassSpec(
    color: const Color(0x26FFFFFF),
    blur: 40,
    borderColor: const Color(0x3DFFFFFF),
    shadows: [
      BoxShadow(color: Colors.black.withOpacity(0.36), blurRadius: 48, offset: const Offset(0, 16)),
      BoxShadow(color: Colors.white.withOpacity(0.09), blurRadius: 0, spreadRadius: 0, offset: const Offset(0, 1)),
    ],
    sheenOpacity: 0.26,
  ),
};

// ─── Convenience: a list-section card (grouped rows, iOS style) ──────────────
class GlassCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const GlassCard({super.key, required this.children, this.padding});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      rows.add(children[i]);
      if (i < children.length - 1) {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(left: 62),
            child: Container(height: 0.5, color: const Color(0x1FFFFFFF)),
          ),
        );
      }
    }
    return GlassContainer(
      borderRadius: 28,
      padding: padding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
    );
  }
}

// ─── Pill badge ──────────────────────────────────────────────────────────────
class GlassPill extends StatelessWidget {
  final String label;
  final Color color;

  const GlassPill({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35), width: 1),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color, letterSpacing: 0.07)),
    );
  }
}

// ─── Primary action button ────────────────────────────────────────────────────
class GlassPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool success;
  final Gradient gradient;
  final Color shadowColor;
  final IconData? icon;

  const GlassPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.success = false,
    this.gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xE65856D6), Color(0xE6007AFF)],
    ),
    this.shadowColor = const Color(0xFF007AFF),
    this.icon,
  });

  @override
  State<GlassPrimaryButton> createState() => _GlassPrimaryButtonState();
}

class _GlassPrimaryButtonState extends State<GlassPrimaryButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween<double>(begin: 1, end: 0.966).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.loading;
    return GestureDetector(
      onTapDown: enabled ? (_) => _ctrl.forward() : null,
      onTapUp: enabled ? (_) { _ctrl.reverse(); widget.onPressed!(); } : null,
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: enabled ? widget.gradient : null,
                color: enabled ? null : const Color(0x14FFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: enabled ? widget.shadowColor.withOpacity(0.45) : const Color(0x1FFFFFFF),
                ),
                boxShadow: enabled
                    ? [BoxShadow(color: widget.shadowColor.withOpacity(0.40), blurRadius: 32, offset: const Offset(0, 8))]
                    : null,
              ),
              child: Stack(
                children: [
                  if (enabled)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [Colors.white.withOpacity(0.22), Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: widget.loading
                        ? SizedBox(width: 22, height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white.withOpacity(0.8),
                            ))
                        : widget.success
                            ? const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 22)
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.icon != null) ...[
                                    Icon(widget.icon, color: enabled ? Colors.white : const Color(0x59FFFFFF), size: 18),
                                    const SizedBox(width: 8),
                                  ],
                                  Text(
                                    widget.label,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.41,
                                      color: enabled ? Colors.white : const Color(0x59FFFFFF),
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Glass text input ─────────────────────────────────────────────────────────
class GlassTextField extends StatefulWidget {
  final String placeholder;
  final IconData? leadingIcon;
  final Widget? trailingWidget;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final int? maxLines;

  const GlassTextField({
    super.key,
    required this.placeholder,
    this.leadingIcon,
    this.trailingWidget,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.errorText,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  final _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: widget.maxLines == 1 ? 56 : null,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: widget.maxLines != 1 ? 14 : 0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x1AFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: hasError
                      ? const Color(0xFFFF3B30).withOpacity(0.70)
                      : _focused
                          ? const Color(0xFF007AFF).withOpacity(0.65)
                          : const Color(0x2BFFFFFF),
                  width: 1,
                ),
                boxShadow: _focused
                    ? [
                        BoxShadow(color: const Color(0xFF007AFF).withOpacity(0.22), blurRadius: 0, spreadRadius: 3),
                        BoxShadow(color: Colors.black.withOpacity(0.28), blurRadius: 32, offset: const Offset(0, 8)),
                      ]
                    : [BoxShadow(color: Colors.black.withOpacity(0.28), blurRadius: 32, offset: const Offset(0, 8))],
              ),
              child: Row(
                children: [
                  if (widget.leadingIcon != null) ...[
                    Icon(widget.leadingIcon, size: 18, color: Colors.white.withOpacity(0.35)),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: TextField(
                      focusNode: _focus,
                      controller: widget.controller,
                      obscureText: widget.obscureText,
                      keyboardType: widget.keyboardType,
                      readOnly: widget.readOnly,
                      maxLines: widget.obscureText ? 1 : widget.maxLines,
                      onChanged: widget.onChanged,
                      style: const TextStyle(fontSize: 17, letterSpacing: -0.41, color: Colors.white),
                      cursorColor: const Color(0xFF007AFF),
                      decoration: InputDecoration(
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 17, letterSpacing: -0.41),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (widget.trailingWidget != null) ...[
                    const SizedBox(width: 8),
                    widget.trailingWidget!,
                  ],
                ],
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text('⚠ ${widget.errorText}',
                style: const TextStyle(fontSize: 12, color: Color(0xFFFF3B30))),
          ),
      ],
    );
  }
}
