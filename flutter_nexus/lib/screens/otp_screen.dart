import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import '../widgets/glass.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  final VoidCallback onVerify;
  final VoidCallback onBack;

  const OTPScreen({super.key, required this.email, required this.onVerify, required this.onBack});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _digits = List.generate(6, (_) => TextEditingController());
  final _focuses = List.generate(6, (_) => FocusNode());
  bool _loading = false;
  String _error = '';
  int _resendSeconds = 30;
  Timer? _timer;

  String get _maskedEmail {
    final e = widget.email;
    final at = e.indexOf('@');
    if (at < 3) return e;
    return '${e.substring(0, 2)}${'*' * (at - 2).clamp(0, 4)}${e.substring(at)}';
  }

  String get _code => _digits.map((c) => c.text).join();
  bool get _allFilled => _digits.every((c) => c.text.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focuses[0].requestFocus());
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds <= 0) { t.cancel(); return; }
      setState(() => _resendSeconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _digits) c.dispose();
    for (final f in _focuses) f.dispose();
    super.dispose();
  }

  void _onDigitInput(int index, String value) {
    final v = value.replaceAll(RegExp(r'\D'), '');
    if (v.isEmpty) {
      _digits[index].text = '';
      setState(() => _error = '');
      return;
    }
    // Handle paste of full code
    if (v.length == 6) {
      for (int i = 0; i < 6; i++) _digits[i].text = v[i];
      setState(() {});
      _focuses[5].requestFocus();
      _verify();
      return;
    }
    _digits[index].text = v[0];
    setState(() => _error = '');
    if (index < 5) {
      _focuses[index + 1].requestFocus();
    } else if (_allFilled) {
      _verify();
    }
  }

  Future<void> _verify() async {
    if (!_allFilled) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1100));
    setState(() => _loading = false);
    widget.onVerify(); // any 6-digit code passes in demo
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
            width: 56, height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.systemBlue.withOpacity(0.20),
              border: Border.all(color: AppColors.systemBlue.withOpacity(0.30)),
              boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.28), blurRadius: 28)],
            ),
            child: const Icon(Icons.shield_outlined, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 20),
          Text('Enter Verification Code', style: AppText.largeTitle),
          const SizedBox(height: 8),
          Text('We sent a 6-digit code to', style: AppText.callout.copyWith(color: AppColors.labelSecondary)),
          Text(_maskedEmail, style: AppText.callout.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 36),

          // OTP inputs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (i) => _DigitField(
              controller: _digits[i],
              focusNode: _focuses[i],
              hasError: _error.isNotEmpty,
              onInput: (v) => _onDigitInput(i, v),
              onBackspace: () {
                if (_digits[i].text.isEmpty && i > 0) {
                  _digits[i - 1].clear();
                  _focuses[i - 1].requestFocus();
                  setState(() {});
                }
              },
            )),
          ),

          if (_error.isNotEmpty) ...[
            const SizedBox(height: 10),
            Center(child: Text('⚠ $_error', style: AppText.caption1.copyWith(color: AppColors.systemRed))),
          ],
          const SizedBox(height: 36),

          // Verify button
          GlassPrimaryButton(
            label: 'Verify & Proceed',
            loading: _loading,
            onPressed: _allFilled && !_loading ? _verify : null,
          ),
          const SizedBox(height: 24),

          // Resend
          Center(
            child: _resendSeconds > 0
                ? RichText(
                    text: TextSpan(
                      text: 'Resend code in ',
                      style: AppText.callout.copyWith(color: AppColors.labelTertiary),
                      children: [
                        TextSpan(
                          text: '0:${_resendSeconds.toString().padLeft(2, '0')}',
                          style: TextStyle(color: AppColors.labelSecondary, fontWeight: FontWeight.w600, fontFeatures: const [FontFeature.tabularFigures()]),
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () => setState(() { _resendSeconds = 30; _startTimer(); }),
                    child: Text('Resend Code', style: AppText.callout.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w600)),
                  ),
          ),
          const SizedBox(height: 14),

          Center(
            child: GestureDetector(
              onTap: widget.onBack,
              child: Text('← Back to Sign In', style: AppText.callout.copyWith(color: AppColors.labelTertiary)),
            ),
          ),
          const SizedBox(height: 28),

          // Security note
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0x0AFFFFFF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x14FFFFFF)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.shield_outlined, size: 16, color: AppColors.systemGreen),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'This code expires in 10 minutes. Never share your verification code with anyone.',
                        style: AppText.caption1.copyWith(color: AppColors.labelTertiary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DigitField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final ValueChanged<String> onInput;
  final VoidCallback onBackspace;

  const _DigitField({
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.onInput,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46, height: 58,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
          child: Focus(
            focusNode: focusNode,
            child: Builder(builder: (ctx) {
              final focused = Focus.of(ctx).hasFocus;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: const Color(0x1AFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hasError
                        ? AppColors.systemRed.withOpacity(0.70)
                        : controller.text.isNotEmpty
                            ? AppColors.systemBlue.withOpacity(0.65)
                            : focused
                                ? AppColors.systemBlue.withOpacity(0.65)
                                : const Color(0x2BFFFFFF),
                    width: 1,
                  ),
                  boxShadow: focused || controller.text.isNotEmpty
                      ? [BoxShadow(color: AppColors.systemBlue.withOpacity(0.20), blurRadius: 0, spreadRadius: 3)]
                      : null,
                ),
                child: Center(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: -0.3),
                    cursorColor: AppColors.systemBlue,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: onInput,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
