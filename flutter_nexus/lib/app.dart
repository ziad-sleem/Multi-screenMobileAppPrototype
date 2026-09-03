import 'package:flutter/material.dart';
import 'models.dart';
import 'theme.dart';
import 'widgets/wallpaper.dart';
import 'widgets/nav_bars.dart';
import 'screens/welcome_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/home_screen.dart';
import 'screens/discover_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_profile_screen.dart';

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.systemBlue,
          secondary: AppColors.systemIndigo,
          surface: Colors.transparent,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      home: const NexusShell(),
    );
  }
}

class NexusShell extends StatefulWidget {
  const NexusShell({super.key});

  @override
  State<NexusShell> createState() => _NexusShellState();
}

class _NexusShellState extends State<NexusShell> with SingleTickerProviderStateMixin {
  bool _authed = false;
  AuthStep _authStep = AuthStep.welcome;
  MainTab _activeTab = MainTab.home;
  bool _editingProfile = false;

  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _navigate(VoidCallback stateChange) async {
    await _fadeCtrl.reverse();
    setState(stateChange);
    _fadeCtrl.forward();
  }

  void _logout() => _navigate(() {
    _authed = false;
    _authStep = AuthStep.welcome;
    _activeTab = MainTab.home;
    _editingProfile = false;
  });

  String get _topBarTitle => switch (_activeTab) {
    MainTab.home     => 'Dashboard',
    MainTab.discover => 'Discover',
    MainTab.activity => 'Activity',
    MainTab.profile  => 'Profile',
  };

  Widget _buildAuthScreen() => switch (_authStep) {
    AuthStep.welcome => WelcomeScreen(
      onGetStarted: () => _navigate(() => _authStep = AuthStep.signUp),
      onSignIn:     () => _navigate(() => _authStep = AuthStep.signIn),
    ),
    AuthStep.signIn => SignInScreen(
      onSignIn: () => _navigate(() => _authStep = AuthStep.otp),
      onSignUp: () => _navigate(() => _authStep = AuthStep.signUp),
    ),
    AuthStep.signUp => SignUpScreen(
      onSignUp: () => _navigate(() => _authStep = AuthStep.otp),
      onSignIn: () => _navigate(() => _authStep = AuthStep.signIn),
    ),
    AuthStep.otp => OTPScreen(
      email: 'alex@example.com',
      onVerify: () => _navigate(() => _authed = true),
      onBack:   () => _navigate(() => _authStep = AuthStep.signIn),
    ),
  };

  Widget _buildMainScreen() {
    if (_editingProfile) {
      return EditProfileScreen(
        onSave: () => _navigate(() => _editingProfile = false),
        onBack: () => _navigate(() => _editingProfile = false),
      );
    }
    return switch (_activeTab) {
      MainTab.home     => const HomeScreen(),
      MainTab.discover => const DiscoverScreen(),
      MainTab.activity => const ActivityScreen(),
      MainTab.profile  => ProfileScreen(
        onEditProfile: () => _navigate(() => _editingProfile = true),
        onLogout: _logout,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040410),
      body: Stack(
        children: [
          // Wallpaper — always behind everything
          const Positioned.fill(child: WallpaperBackground()),

          // Screen content with fade transition
          FadeTransition(
            opacity: _fadeAnim,
            child: _authed ? _buildMainScreen() : _buildAuthScreen(),
          ),

          // Navigation — only in main authenticated app
          if (_authed && !_editingProfile) ...[
            Positioned(
              top: 0, left: 0, right: 0,
              child: NexusTopBar(title: _topBarTitle),
            ),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: NexusBottomNav(
                activeTab: _activeTab,
                onTabChanged: (tab) => setState(() => _activeTab = tab),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
