import 'package:flutter/material.dart';
import 'package:pathfinder/core/theme/app_theme.dart';
import 'package:pathfinder/features/quiz/quiz_screen.dart';
import 'package:pathfinder/features/profile/profile_screen.dart';
import 'package:pathfinder/features/roadmap/roadmap_screen.dart';
import 'package:pathfinder/features/chat/chat_screen.dart';
import 'package:pathfinder/shared/widgets/career_badge_widget.dart';
import 'package:pathfinder/shared/widgets/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const _HomeTab(),
    const QuizScreen(),
    const ChatScreen(),
    const RoadmapScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) =>
              setState(() => _currentIndex = index),
          backgroundColor: AppTheme.surface,
          indicatorColor: AppTheme.primary.withOpacity(0.1),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: AppTheme.textSecondary),
              selectedIcon: Icon(Icons.home_rounded, color: AppTheme.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.quiz_outlined, color: AppTheme.textSecondary),
              selectedIcon: Icon(Icons.quiz_rounded, color: AppTheme.primary),
              label: 'Quiz',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline,
                  color: AppTheme.textSecondary),
              selectedIcon:
                  Icon(Icons.chat_bubble_rounded, color: AppTheme.primary),
              label: 'AI Chat',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined, color: AppTheme.textSecondary),
              selectedIcon: Icon(Icons.map_rounded, color: AppTheme.primary),
              label: 'Roadmap',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: AppTheme.textSecondary),
              selectedIcon: Icon(Icons.person_rounded, color: AppTheme.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  String _userName = 'Student';
  String? _savedTrack;
  bool _apiOnline = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final online = await ApiService.isOnline();
    final track = await ApiService.getSavedCareerTrack();
    if (mounted) {
      setState(() {
        _userName = prefs.getString('user_name') ?? 'Student';
        _apiOnline = online;
        _savedTrack = track;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $_userName 👋',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Text(
                      'PathFinder',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _apiOnline
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _apiOnline
                              ? Colors.green.withOpacity(0.3)
                              : Colors.red.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.circle,
                              size: 8,
                              color: _apiOnline ? Colors.green : Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            _apiOnline ? 'Online' : 'Offline',
                            style: TextStyle(
                              color: _apiOnline ? Colors.green : Colors.red,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Icon(Icons.explore_rounded,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Saved Track
            if (_savedTrack != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.withOpacity(0.25)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle,
                          color: Colors.green, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Your Career Track',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11,
                                  fontFamily: 'Poppins')),
                          Text(_savedTrack!,
                              style: const TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  RoadmapScreen(careerTrack: _savedTrack))),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.green, size: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Banner Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('AI-Powered',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Find Your\nCareer Path 🧭',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Take the quiz and get your personalized learning roadmap',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => QuizScreen())),
                    child: const Text('Start Quiz →',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 13)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Career Tracks',
                    style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
                Text('Tap to explore',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        fontFamily: 'Poppins')),
              ],
            ),
            const SizedBox(height: 14),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
              children: [
                CareerBadgeWidget(
                  title: 'Artificial Intelligence',
                  icon: Icons.psychology_rounded,
                  color: const Color(0xFF6C63FF),
                  imagePath: 'assets/images/track_ai.svg',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RoadmapScreen(
                              careerTrack: 'Artificial Intelligence'))),
                ),
                CareerBadgeWidget(
                  title: 'Data Science',
                  icon: Icons.bar_chart_rounded,
                  color: const Color(0xFF00897B),
                  imagePath: 'assets/images/track_data.svg',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RoadmapScreen(
                              careerTrack: 'Data Science'))),
                ),
                CareerBadgeWidget(
                  title: 'Development',
                  icon: Icons.code_rounded,
                  color: const Color(0xFFE53935),
                  imagePath: 'assets/images/track_coding.svg',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RoadmapScreen(
                              careerTrack: 'Software Development'))),
                ),
                CareerBadgeWidget(
                  title: 'Security',
                  icon: Icons.security_rounded,
                  color: const Color(0xFFF57C00),
                  imagePath: 'assets/images/track_security.svg',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RoadmapScreen(
                              careerTrack: 'Cybersecurity'))),
                ),
                CareerBadgeWidget(
                  title: 'Software Eng',
                  icon: Icons.engineering_rounded,
                  color: const Color(0xFF2E7D32),
                  imagePath: 'assets/images/track_software.svg',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RoadmapScreen(
                              careerTrack: 'Software Engineering'))),
                ),
                CareerBadgeWidget(
                  title: 'UI/UX Design',
                  icon: Icons.design_services_rounded,
                  color: AppTheme.primary,
                  imagePath: 'assets/images/track_uiux.svg',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const RoadmapScreen(careerTrack: 'UI/UX'))),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
