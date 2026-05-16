import 'package:flutter/material.dart';
import 'package:pathfinder/core/theme/app_theme.dart';
import 'package:pathfinder/features/roadmap/roadmap_screen.dart';
import 'package:pathfinder/shared/widgets/api_service.dart';
import 'package:pathfinder/shared/widgets/pdf_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, int> answers;
  const ResultScreen({super.key, required this.answers});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _saved = false;
  bool _isSaving = false;

  String _getCareerTrack() {
    int maxVal = -1;
    String maxKey = 'ai';
    widget.answers.forEach((key, value) {
      if (value > maxVal) {
        maxVal = value;
        maxKey = key;
      }
    });
    switch (maxKey) {
      case 'ai':
        return 'Artificial Intelligence';
      case 'data':
        return 'Data Science';
      case 'coding':
        return 'Software Development';
      case 'security':
        return 'Cybersecurity';
      case 'design':
        return 'UI/UX Design';
      default:
        return 'Software Engineering';
    }
  }

  IconData _getIcon(String track) {
    switch (track) {
      case 'Artificial Intelligence':
        return Icons.psychology_rounded;
      case 'Data Science':
        return Icons.bar_chart_rounded;
      case 'Software Development':
        return Icons.code_rounded;
      case 'Cybersecurity':
        return Icons.security_rounded;
      case 'UI/UX Design':
        return Icons.design_services_rounded;
      default:
        return Icons.engineering_rounded;
    }
  }

  Color _getColor(String track) {
    switch (track) {
      case 'Artificial Intelligence':
        return const Color(0xFF6C63FF);
      case 'Data Science':
        return const Color(0xFF00897B);
      case 'Software Development':
        return const Color(0xFFE53935);
      case 'Cybersecurity':
        return const Color(0xFFF57C00);
      case 'UI/UX Design':
        return AppTheme.primary;
      default:
        return const Color(0xFF2E7D32);
    }
  }

  void _saveResult(String track) async {
    setState(() => _isSaving = true);
    await ApiService.saveQuizResult(
        careerTrack: track, answers: widget.answers);
    setState(() {
      _isSaving = false;
      _saved = true;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Row(children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 8),
          Text('Result saved!', style: TextStyle(fontFamily: 'Poppins')),
        ]),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
    }
  }

  void _shareResult(String track) {
    Share.share(
      ' My PathFinder Career Result!\n\nMy recommended track is:\n $track \n\nFind your career path too! ',
      subject: 'My PathFinder Career Result',
    );
  }

  void _downloadPdf(String track) async {
    final prefs = await SharedPreferences.getInstance();
    await PdfService.generateCareerReport(
      userName: prefs.getString('user_name') ?? 'Student',
      userEmail: prefs.getString('user_email') ?? '',
      careerTrack: track,
      answers: widget.answers,
    );
  }

  @override
  Widget build(BuildContext context) {
    final track = _getCareerTrack();
    final icon = _getIcon(track);
    final color = _getColor(track);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.border),
                      ),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: AppTheme.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Your Result',
                      style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins')),
                ],
              ),
              const SizedBox(height: 24),

              // Result Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        color: color.withOpacity(0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 10))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 42),
                    ),
                    const SizedBox(height: 16),
                    const Text('🎉 Congratulations!',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontFamily: 'Poppins')),
                    const SizedBox(height: 4),
                    Text(track,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Your Recommended Career Path',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Poppins')),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Action Buttons
              if (!_saved)
                _ActionButton(
                  label: 'Save Result',
                  icon: Icons.save_rounded,
                  color: color,
                  isOutlined: true,
                  isLoading: _isSaving,
                  onTap: () => _saveResult(track),
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Result Saved!',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              _ActionButton(
                label: 'Share My Result',
                icon: Icons.share_rounded,
                color: Colors.green,
                onTap: () => _shareResult(track),
              ),
              const SizedBox(height: 10),
              _ActionButton(
                label: 'Download PDF Report',
                icon: Icons.picture_as_pdf_rounded,
                color: AppTheme.primary,
                onTap: () => _downloadPdf(track),
              ),
              const SizedBox(height: 24),

              // Skills Breakdown
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.border),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Skills Breakdown',
                        style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins')),
                    const SizedBox(height: 16),
                    ...widget.answers.entries.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(e.key.toUpperCase(),
                                      style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 11,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600)),
                                  Text('${((e.value / 3) * 100).toInt()}%',
                                      style: TextStyle(
                                          color: color,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins')),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: e.value / 3,
                                  backgroundColor: AppTheme.background,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(color),
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // View Roadmap
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RoadmapScreen(careerTrack: track))),
                  icon: const Icon(Icons.map_rounded),
                  label: const Text('View My Roadmap',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins')),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textSecondary,
                    side: const BorderSide(color: AppTheme.border),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Retake Quiz',
                      style: TextStyle(fontFamily: 'Poppins')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isOutlined;
  final bool isLoading;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: isOutlined
            ? OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: isLoading ? null : onTap,
                icon: isLoading
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: color))
                    : Icon(icon),
                label: Text(label,
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              )
            : ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: onTap,
                icon: Icon(icon),
                label: Text(label,
                    style: const TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
              ));
  }
}
