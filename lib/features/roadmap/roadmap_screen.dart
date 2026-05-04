import 'package:flutter/material.dart';
import 'package:pathfinder/core/theme/app_theme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RoadmapScreen extends StatelessWidget {
  final String? careerTrack;
  const RoadmapScreen({super.key, this.careerTrack});

  List<Map<String, dynamic>> _getRoadmap(String track) {
    switch (track) {
      case 'Artificial Intelligence':
        return [
          {'title': 'Python Basics', 'duration': '4 weeks', 'progress': 100},
          {
            'title': 'Mathematics & Statistics',
            'duration': '6 weeks',
            'progress': 60
          },
          {'title': 'Machine Learning', 'duration': '8 weeks', 'progress': 30},
          {'title': 'Deep Learning', 'duration': '8 weeks', 'progress': 0},
          {'title': 'AI Projects', 'duration': '4 weeks', 'progress': 0},
        ];
      case 'Data Science':
        return [
          {'title': 'Python & SQL', 'duration': '4 weeks', 'progress': 100},
          {'title': 'Data Analysis', 'duration': '4 weeks', 'progress': 50},
          {
            'title': 'Data Visualization',
            'duration': '3 weeks',
            'progress': 20
          },
          {'title': 'Machine Learning', 'duration': '6 weeks', 'progress': 0},
          {
            'title': 'Data Science Projects',
            'duration': '4 weeks',
            'progress': 0
          },
        ];
      case 'Cybersecurity':
        return [
          {
            'title': 'Networking Basics',
            'duration': '4 weeks',
            'progress': 100
          },
          {
            'title': 'Linux Fundamentals',
            'duration': '3 weeks',
            'progress': 40
          },
          {'title': 'Ethical Hacking', 'duration': '6 weeks', 'progress': 0},
          {'title': 'Security Tools', 'duration': '4 weeks', 'progress': 0},
          {'title': 'CTF Challenges', 'duration': '4 weeks', 'progress': 0},
        ];
      case 'UI/UX':
        return [
          {
            'title': 'Design Principles',
            'duration': '2 weeks',
            'progress': 100
          },
          {'title': 'Figma Basics', 'duration': '3 weeks', 'progress': 70},
          {'title': 'User Research', 'duration': '3 weeks', 'progress': 20},
          {'title': 'Prototyping', 'duration': '4 weeks', 'progress': 0},
          {'title': 'Portfolio Projects', 'duration': '4 weeks', 'progress': 0},
        ];
      default:
        return [
          {
            'title': 'Programming Basics',
            'duration': '4 weeks',
            'progress': 100
          },
          {'title': 'Data Structures', 'duration': '4 weeks', 'progress': 50},
          {'title': 'Algorithms', 'duration': '4 weeks', 'progress': 20},
          {'title': 'System Design', 'duration': '6 weeks', 'progress': 0},
          {'title': 'Real Projects', 'duration': '4 weeks', 'progress': 0},
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final track = careerTrack ?? 'Software Development';
    final roadmap = _getRoadmap(track);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Roadmap 🗺️',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              track,
              style: const TextStyle(
                color: AppTheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            // Overall Progress
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overall Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 12),
                  StepProgressIndicator(
                    totalSteps: 100,
                    currentStep: 32,
                    size: 8,
                    padding: 0,
                    roundedEdges: const Radius.circular(10),
                    selectedGradientColor: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppTheme.primary, Color(0xFF9C63FF)],
                    ),
                    unselectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.surface,
                        AppTheme.textSecondary.withOpacity(0.3)
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '32% Completed',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(roadmap.length, (i) {
              final step = roadmap[i];
              final isLast = i == roadmap.length - 1;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: step['progress'] == 100
                              ? Colors.green
                              : AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: step['progress'] == 100
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 18)
                              : Text(
                                  '${i + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 80,
                          color: AppTheme.primary.withOpacity(0.3),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppTheme.primary.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                step['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                '${step['progress']}%',
                                style: TextStyle(
                                  color: step['progress'] == 100
                                      ? Colors.green
                                      : AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step['duration'],
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 8),
                          StepProgressIndicator(
                            totalSteps: 100,
                            currentStep: step['progress'],
                            size: 6,
                            padding: 0,
                            roundedEdges: const Radius.circular(10),
                            selectedGradientColor: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppTheme.primary, Color(0xFF9C63FF)],
                            ),
                            unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppTheme.surface,
                                AppTheme.textSecondary.withOpacity(0.2)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
