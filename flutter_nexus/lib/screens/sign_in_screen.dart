import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;

  const SignInScreen({super.key, required this.onSignIn, required this.onSignUp});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  bool _showPw = false;
  String _emailError = '';
  bool _loading = false;

  String _validateEmail(String v) {
    if (v.isEmpty) return 'Email is required';
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!re.hasMatch(v)) return 'Enter a valid email address';
    return '';
  }

  Future<void> _handleSignIn() async {
    final err = _validateEmail(_emailCtrl.text);
    if (err.isNotEmpty) { setState(() => _emailError = err); return; }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => _loading = false);
    widget.onSignIn();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, topPad + 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [AppColors.systemIndigo, AppColors.systemBlue],
              ),
              boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.40), blurRadius: 20)],
            ),
            child: const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 16),
          Text('Welcome Back', style: AppText.largeTitle),
          const SizedBox(height: 6),
          Text('Sign in to continue to Nexus', style: AppText.callout.copyWith(color: AppColors.labelSecondary)),
          const SizedBox(height: 32),

          // Email
          _Label('Email or Username'),
          const SizedBox(height: 6),
          GlassTextField(
            placeholder: 'alex@example.com',
            leadingIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            controller: _emailCtrl,
            errorText: _emailError.isEmpty ? null : _emailError,
            onChanged: (_) => setState(() => _emailError = ''),
          ),
          const SizedBox(height: 14),

          // Password
          _Label('Password'),
          const SizedBox(height: 6),
          GlassTextField(
            placeholder: 'Enter your password',
            leadingIcon: Icons.lock_outline_rounded,
            obscureText: !_showPw,
            controller: _pwCtrl,
            trailingWidget: GestureDetector(
              onTap: () => setState(() => _showPw = !_showPw),
              child: Icon(
                _showPw ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 20,
                color: Colors.white.withOpacity(0.40),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Forgot password
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onSignIn, // demo: go to OTP
              child: Text('Forgot Password?',
                  style: AppText.callout.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w500)),
            ),
          ),
          const SizedBox(height: 28),

          // Sign In button
          GlassPrimaryButton(label: 'Sign In', onPressed: _loading ? null : _handleSignIn, loading: _loading),
          const SizedBox(height: 28),

          // Divider
          Row(
            children: [
              Expanded(child: Container(height: 0.5, color: AppColors.separator)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text('or continue with', style: AppText.caption1.copyWith(color: AppColors.labelTertiary)),
              ),
              Expanded(child: Container(height: 0.5, color: AppColors.separator)),
            ],
          ),
          const SizedBox(height: 20),

          // Social buttons
          Row(
            children: [
              _SocialButton(icon: _GoogleIcon(), label: 'Google', onTap: widget.onSignIn),
              const SizedBox(width: 10),
              _SocialButton(icon: const Icon(Icons.apple_rounded, color: Colors.white, size: 22), label: 'Apple', onTap: widget.onSignIn),
              const SizedBox(width: 10),
              _SocialButton(icon: _GithubIcon(), label: 'GitHub', onTap: widget.onSignIn),
            ],
          ),
          const SizedBox(height: 24),

          // Sign up
          Center(
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: AppText.callout.copyWith(color: AppColors.labelSecondary),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: widget.onSignUp,
                      child: Text('Sign Up', style: AppText.callout.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: AppText.footnote.copyWith(color: Colors.white.withOpacity(0.60), fontWeight: FontWeight.w500));
}

class _SocialButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0x1AFFFFFF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x2BFFFFFF)),
              ),
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20, height: 20,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24;
    void circle(String hex, Rect r) {
      final p = Paint()..color = Color(int.parse('FF$hex', radix: 16));
      canvas.drawArc(r, 0, 0, false, p); // placeholder - use path below
    }
    _ = circle;
    final paths = [
      ('4285F4', 'M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z'),
      ('34A853', 'M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z'),
      ('FBBC05', 'M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z'),
      ('EA4335', 'M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z'),
    ];
    for (final (hex, d) in paths) {
      final paint = Paint()
        ..color = Color(int.parse('FF$hex', radix: 16))
        ..style = PaintingStyle.fill;
      final path = parseSvgPath(d, scale);
      canvas.drawPath(path, paint);
    }
  }

  Path parseSvgPath(String d, double scale) {
    // Simplified SVG path parser for these specific Google icon paths
    final path = Path();
    final cmds = d.trim().split(RegExp(r'(?=[MLCHVZz])'));
    double cx = 0, cy = 0;
    for (final cmd in cmds) {
      if (cmd.isEmpty) continue;
      final type = cmd[0];
      final nums = RegExp(r'[-\d.]+').allMatches(cmd.substring(1))
          .map((m) => double.parse(m.group(0)!) * scale).toList();
      switch (type) {
        case 'M': if (nums.length >= 2) { path.moveTo(nums[0], nums[1]); cx = nums[0]; cy = nums[1]; }
        case 'L': if (nums.length >= 2) { path.lineTo(nums[0], nums[1]); cx = nums[0]; cy = nums[1]; }
        case 'C': if (nums.length >= 6) {
          path.cubicTo(nums[0], nums[1], nums[2], nums[3], nums[4], nums[5]);
          cx = nums[4]; cy = nums[5];
        }
        case 'Z': case 'z': path.close();
        default: break;
      }
    }
    _ = cx; _ = cy;
    return path;
  }

  @override
  bool shouldRepaint(_) => false;
}

class _GithubIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Icon(Icons.code_rounded, color: Colors.white, size: 22);
}
