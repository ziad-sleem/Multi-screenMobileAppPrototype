import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/glass.dart';
import '../widgets/avatar.dart';

class EditProfileScreen extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onBack;

  const EditProfileScreen({super.key, required this.onSave, required this.onBack});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _firstCtrl    = TextEditingController(text: 'Alex');
  final _lastCtrl     = TextEditingController(text: 'Johnson');
  final _usernameCtrl = TextEditingController(text: 'alexjohnson');
  final _bioCtrl      = TextEditingController(text: 'Senior Product Designer crafting digital experiences that matter. Building the future of work at Nexus.');
  final _phoneCtrl    = TextEditingController(text: '555-012-3456');
  bool _loading = false;
  bool _saved   = false;

  int get _bioLength => _bioCtrl.text.length;

  @override
  void initState() {
    super.initState();
    _bioCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _firstCtrl.dispose(); _lastCtrl.dispose(); _usernameCtrl.dispose();
    _bioCtrl.dispose(); _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() { _loading = false; _saved = true; });
    await Future.delayed(const Duration(milliseconds: 600));
    widget.onSave();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final name = '${_firstCtrl.text} ${_lastCtrl.text}'.trim();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Custom floating top bar
          Padding(
            padding: EdgeInsets.only(top: topPad + 8, left: 16, right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0x12FFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0x21FFFFFF)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.22), blurRadius: 20, offset: const Offset(0, 4))],
                  ),
                  child: Stack(
                    children: [
                      // Sheen
                      Positioned.fill(child: IgnorePointer(child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomCenter,
                                colors: [Colors.white.withOpacity(0.16), Colors.transparent], stops: const [0.0, 0.45])),
                      ))),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: widget.onBack,
                            child: Row(children: [
                              const Icon(Icons.chevron_left_rounded, color: AppColors.systemBlue, size: 22),
                              Text('Back', style: AppText.callout.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w500)),
                            ]),
                          ),
                          Expanded(child: Center(child: Text('Edit Profile', style: AppText.headline))),
                          GestureDetector(
                            onTap: _loading ? null : _handleSave,
                            child: Text('Save', style: AppText.callout.copyWith(
                                color: _loading ? AppColors.systemBlue.withOpacity(0.50) : AppColors.systemBlue,
                                fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, topPad + 88, 16, 120),
              children: [
                // Avatar picker
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          AppAvatar(name: name.isEmpty ? 'AJ' : name, size: 88),
                          Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                              width: 30, height: 30,
                              decoration: BoxDecoration(
                                color: AppColors.systemBlue,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black.withOpacity(0.45), width: 1.5),
                                boxShadow: [BoxShadow(color: AppColors.systemBlue.withOpacity(0.50), blurRadius: 12)],
                              ),
                              child: const Icon(Icons.camera_alt_outlined, size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('Change Photo', style: AppText.callout.copyWith(color: AppColors.systemBlue, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Name fields
                GlassCard(children: [
                  _InlineField(label: 'First Name', controller: _firstCtrl, placeholder: 'First name',
                      onChanged: (_) => setState(() {})),
                  _InlineField(label: 'Last Name', controller: _lastCtrl, placeholder: 'Last name',
                      onChanged: (_) => setState(() {})),
                ]),
                const SizedBox(height: 14),

                // Username
                GlassCard(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Row(children: [
                          Icon(Icons.alternate_email_rounded, size: 16, color: AppColors.labelSecondary),
                          const SizedBox(width: 4),
                          Text('Username', style: AppText.footnote.copyWith(color: AppColors.labelSecondary, fontWeight: FontWeight.w500)),
                        ]),
                        const SizedBox(width: 16),
                        Text('@', style: AppText.callout.copyWith(color: AppColors.labelTertiary)),
                        const SizedBox(width: 2),
                        Expanded(
                          child: TextField(
                            controller: _usernameCtrl,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 16, color: Colors.white, letterSpacing: -0.32),
                            cursorColor: AppColors.systemBlue,
                            decoration: InputDecoration(
                              hintText: 'username',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 16),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (v) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(height: 14),

                // Bio
                GlassContainer(
                  borderRadius: 24,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Bio', style: AppText.footnote.copyWith(color: AppColors.labelSecondary, fontWeight: FontWeight.w500)),
                          Text('$_bioLength/150', style: AppText.caption2.copyWith(
                            color: _bioLength > 140 ? AppColors.systemOrange : _bioLength >= 150 ? AppColors.systemRed : AppColors.labelTertiary,
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _bioCtrl,
                        maxLines: 4,
                        maxLength: 150,
                        buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
                        style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5, letterSpacing: -0.32),
                        cursorColor: AppColors.systemBlue,
                        decoration: InputDecoration(
                          hintText: 'Tell people about yourself…',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 16),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: (_bioLength / 150).clamp(0.0, 1.0),
                          minHeight: 3,
                          backgroundColor: const Color(0x1AFFFFFF),
                          valueColor: AlwaysStoppedAnimation(
                            _bioLength > 140 ? AppColors.systemOrange : AppColors.systemBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Contact
                GlassCard(children: [
                  // Email (verified, read-only)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.mail_outline_rounded, size: 18, color: AppColors.labelTertiary),
                        const SizedBox(width: 12),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email', style: AppText.caption2.copyWith(color: AppColors.labelTertiary)),
                            const SizedBox(height: 1),
                            Text('alex@example.com', style: AppText.callout.copyWith(color: Colors.white.withOpacity(0.70))),
                          ],
                        )),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.systemGreen.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.systemGreen.withOpacity(0.35)),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            const Icon(Icons.check_circle_outline_rounded, size: 12, color: AppColors.systemGreen),
                            const SizedBox(width: 4),
                            Text('Verified', style: AppText.caption2.copyWith(color: AppColors.systemGreen, fontWeight: FontWeight.w600)),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  // Phone
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_outlined, size: 18, color: AppColors.labelTertiary),
                        const SizedBox(width: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0x0AFFFFFF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.separator),
                              ),
                              child: Text('+1', style: AppText.callout.copyWith(color: AppColors.labelSecondary, fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(fontSize: 16, color: Colors.white, letterSpacing: -0.32),
                            cursorColor: AppColors.systemBlue,
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 16),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
      // Sticky Save Changes button
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.paddingOf(context).bottom + 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Colors.transparent, const Color(0xFF050510).withOpacity(0.97)],
          ),
        ),
        child: GlassPrimaryButton(
          label: _saved ? 'Saved!' : 'Save Changes',
          loading: _loading,
          success: _saved,
          onPressed: _loading ? null : _handleSave,
          gradient: _saved
              ? const LinearGradient(colors: [Color(0xE634C759), Color(0xE634C759)])
              : const LinearGradient(
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                  colors: [Color(0xE65856D6), Color(0xE6007AFF)]),
          shadowColor: _saved ? AppColors.systemGreen : AppColors.systemBlue,
        ),
      ),
    );
  }
}

class _InlineField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String placeholder;
  final ValueChanged<String>? onChanged;

  const _InlineField({
    required this.label,
    required this.controller,
    required this.placeholder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: Text(label, style: AppText.footnote.copyWith(color: AppColors.labelSecondary, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 16, color: Colors.white, letterSpacing: -0.32),
              cursorColor: AppColors.systemBlue,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 16),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
