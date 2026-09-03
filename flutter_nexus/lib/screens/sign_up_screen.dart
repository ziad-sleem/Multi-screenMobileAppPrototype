import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onSignUp;
  final VoidCallback onSignIn;

  const SignUpScreen({super.key, required this.onSignUp, required this.onSignIn});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameCtrl    = TextEditingController();
  final _emailCtrl   = TextEditingController();
  final _pwCtrl      = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showPw      = false;
  bool _showConfirm = false;
  bool _agreed      = false;
  bool _loading     = false;

  bool get _canSubmit =>
      _nameCtrl.text.isNotEmpty &&
      _emailCtrl.text.isNotEmpty &&
      _pwCtrl.text.length >= 8 &&
      _pwCtrl.text == _confirmCtrl.text &&
      _agreed;

  int _strengthScore(String pw) {
    int s = 0;
    if (pw.length >= 8) s++;
    if (pw.contains(RegExp(r'[A-Z]'))) s++;
    if (pw.contains(RegExp(r'[0-9]'))) s++;
    if (pw.contains(RegExp(r'[^A-Za-z0-9]'))) s++;
    return s;
  }

  (String, Color) _strengthLabel(int score) => switch (score) {
    1 => ('Weak',   AppColors.systemRed),
    2 => ('Fair',   AppColors.systemOrange),
    3 => ('Strong', AppColors.systemYellow),
    4 => ('Secure', AppColors.systemGreen),
    _ => ('',       Colors.transparent),
  };

  Future<void> _handleCreate() async {
    if (!_canSubmit) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1100));
    setState(() => _loading = false);
    widget.onSignUp();
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose(); _pwCtrl.dispose(); _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final score  = _strengthScore(_pwCtrl.text);
    final (strengthLabel, strengthColor) = _strengthLabel(score);
    final pwMismatch = _confirmCtrl.text.isNotEmpty && _pwCtrl.text != _confirmCtrl.text;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, topPad + 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [AppColors.systemPurple, AppColors.systemIndigo],
                  ),
                  boxShadow: [BoxShadow(color: AppColors.systemPurple.withOpacity(0.40), blurRadius: 20)],
                ),
                child: const Icon(Icons.person_outline_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create Account', style: AppText.title2),
                  Row(
                    children: [
                      Text('Step 1 of 2 ', style: AppText.footnote.copyWith(color: AppColors.labelTertiary)),
                      _StepDots(current: 0),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Join Nexus and start managing your work intelligently.',
              style: AppText.callout.copyWith(color: AppColors.labelSecondary)),
          const SizedBox(height: 28),

          // Full name
          _Label('Full Name'),
          const SizedBox(height: 6),
          GlassTextField(placeholder: 'Alex Johnson', leadingIcon: Icons.person_outline_rounded, controller: _nameCtrl,
              onChanged: (_) => setState(() {})),
          const SizedBox(height: 14),

          // Email
          _Label('Email Address'),
          const SizedBox(height: 6),
          GlassTextField(placeholder: 'alex@example.com', leadingIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress, controller: _emailCtrl, onChanged: (_) => setState(() {})),
          const SizedBox(height: 14),

          // Password
          _Label('Password'),
          const SizedBox(height: 6),
          GlassTextField(
            placeholder: 'Minimum 8 characters',
            leadingIcon: Icons.lock_outline_rounded,
            obscureText: !_showPw,
            controller: _pwCtrl,
            onChanged: (_) => setState(() {}),
            trailingWidget: GestureDetector(
              onTap: () => setState(() => _showPw = !_showPw),
              child: Icon(_showPw ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 20, color: Colors.white.withOpacity(0.40)),
            ),
          ),
          if (_pwCtrl.text.isNotEmpty) ...[
            const SizedBox(height: 8),
            _StrengthBar(score: score),
            const SizedBox(height: 4),
            if (strengthLabel.isNotEmpty)
              Text(strengthLabel, style: AppText.caption1.copyWith(color: strengthColor, fontWeight: FontWeight.w500)),
          ],
          const SizedBox(height: 14),

          // Confirm password
          _Label('Confirm Password'),
          const SizedBox(height: 6),
          GlassTextField(
            placeholder: 'Re-enter password',
            leadingIcon: Icons.lock_outline_rounded,
            obscureText: !_showConfirm,
            controller: _confirmCtrl,
            errorText: pwMismatch ? 'Passwords do not match' : null,
            onChanged: (_) => setState(() {}),
            trailingWidget: GestureDetector(
              onTap: () => setState(() => _showConfirm = !_showConfirm),
              child: Icon(_showConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 20, color: Colors.white.withOpacity(0.40)),
            ),
          ),
          const SizedBox(height: 20),

          // Terms checkbox
          GestureDetector(
            onTap: () => setState(() => _agreed = !_agreed),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: _agreed ? AppColors.systemBlue : const Color(0x14FFFFFF),
                    border: Border.all(color: _agreed ? AppColors.systemBlue : const Color(0x33FFFFFF)),
                    boxShadow: _agreed ? [BoxShadow(color: AppColors.systemBlue.withOpacity(0.40), blurRadius: 8)] : null,
                  ),
                  child: _agreed ? const Icon(Icons.check_rounded, size: 13, color: Colors.white) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'I agree to the ',
                      style: AppText.footnote.copyWith(color: AppColors.labelSecondary),
                      children: [
                        TextSpan(text: 'Terms of Service', style: TextStyle(color: AppColors.systemBlue)),
                        const TextSpan(text: ' and '),
                        TextSpan(text: 'Privacy Policy', style: TextStyle(color: AppColors.systemBlue)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Create Account
          GlassPrimaryButton(
            label: 'Create Account',
            loading: _loading,
            onPressed: _canSubmit ? _handleCreate : null,
            gradient: const LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xE6AF52DE), Color(0xE65856D6)],
            ),
            shadowColor: AppColors.systemPurple,
          ),
          const SizedBox(height: 20),

          Center(
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: AppText.callout.copyWith(color: AppColors.labelSecondary),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: widget.onSignIn,
                      child: Text('Sign In', style: AppText.callout.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w600)),
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

class _StepDots extends StatelessWidget {
  final int current;
  const _StepDots({required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(2, (i) => Container(
        margin: const EdgeInsets.only(right: 4),
        width: 20, height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: i == current ? AppColors.systemBlue : const Color(0x33FFFFFF),
        ),
      )),
    );
  }
}

class _StrengthBar extends StatelessWidget {
  final int score;
  const _StrengthBar({required this.score});

  Color _barColor(int score) => switch (score) {
    1 => AppColors.systemRed,
    2 => AppColors.systemOrange,
    3 => AppColors.systemYellow,
    4 => AppColors.systemGreen,
    _ => Colors.transparent,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (i) => Expanded(
        child: Container(
          margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: (i < score) ? _barColor(score) : const Color(0x1AFFFFFF),
          ),
        ),
      )),
    );
  }
}
