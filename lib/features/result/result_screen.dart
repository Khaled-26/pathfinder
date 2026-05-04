import 'package:flutter/material.dart';
import 'package:pathfinder/core/theme/app_theme.dart';
import 'package:pathfinder/features/roadmap/roadmap_screen.dart';
import 'package:pathfinder/shared/widgets/api_service.dart';

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
        return Icons.psychology;
      case 'Data Science':
        return Icons.bar_chart;
      case 'Software Development':
        return Icons.code;
      case 'Cybersecurity':
        return Icons.security;
      case 'UI/UX Design':
        return Icons.design_services;
      default:
        return Icons.engineering;
    }
  }

  Color _getColor(String track) {
    switch (track) {
      case 'Artificial Intelligence':
        return const Color(0xFF6C63FF);
      case 'Data Science':
        return const Color(0xFF03DAC6);
      case 'Software Development':
        return const Color(0xFFFF6584);
      case 'Cybersecurity':
        return const Color(0xFFFFB347);
      case 'UI/UX Design':
        return const Color(0xFFE91E63);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  void _saveResult(String track) async {
    setState(() => _isSaving = true);
    await ApiService.saveQuizResult(
      careerTrack: track,
      answers: widget.answers,
    );
    setState(() {
      _isSaving = false;
      _saved = true;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Result saved!', style: TextStyle(fontFamily: 'Poppins')),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final track = _getCareerTrack();
    final icon = _getIcon(track);
    final color = _getColor(track);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '🎉 Your Result!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Based on your answers, we recommend:',
                style: TextStyle(
                    color: AppTheme.textSecondary, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 38),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      track,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'This is your recommended career path',
                      style: TextStyle(
                          color: Colors.white70, fontFamily: 'Poppins'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Save Button
              if (!_saved)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: color,
                      side: BorderSide(color: color),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isSaving ? null : () => _saveResult(track),
                    icon: _isSaving
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: Text(
                      _isSaving ? 'Saving...' : 'Save Result',
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Text('Result Saved!',
                          style: TextStyle(
                              color: Colors.green, fontFamily: 'Poppins')),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skills Breakdown',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...widget.answers.entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.key.toUpperCase(),
                                style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 11,
                                    fontFamily: 'Poppins')),
                            Text('${((e.value / 3) * 100).toInt()}%',
                                style: TextStyle(
                                    color: color,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins')),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: e.value / 3,
                            backgroundColor: AppTheme.surface,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            minHeight: 7,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RoadmapScreen(careerTrack: track)),
                  ),
                  child: const Text(
                    'View My Roadmap 🗺️',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: AppTheme.primary),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
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
