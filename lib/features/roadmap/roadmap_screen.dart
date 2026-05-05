import 'package:flutter/material.dart';
import 'package:pathfinder/core/theme/app_theme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadmapScreen extends StatelessWidget {
  final String? careerTrack;
  const RoadmapScreen({super.key, this.careerTrack});

  List<Map<String, dynamic>> _getRoadmap(String track) {
    switch (track) {
      case 'Artificial Intelligence':
        return [
          {
            'title': 'Python Basics',
            'duration': '4 weeks',
            'progress': 100,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Mathematics & Statistics',
            'duration': '6 weeks',
            'progress': 60,
            'url': 'https://www.khanacademy.org/math/statistics-probability'
          },
          {
            'title': 'Machine Learning',
            'duration': '8 weeks',
            'progress': 30,
            'url': 'https://www.coursera.org/learn/machine-learning'
          },
          {
            'title': 'Deep Learning',
            'duration': '8 weeks',
            'progress': 0,
            'url': 'https://www.coursera.org/specializations/deep-learning'
          },
          {
            'title': 'AI Projects',
            'duration': '4 weeks',
            'progress': 0,
            'url': 'https://www.kaggle.com'
          },
        ];
      case 'Data Science':
        return [
          {
            'title': 'Python & SQL',
            'duration': '4 weeks',
            'progress': 100,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Data Analysis',
            'duration': '4 weeks',
            'progress': 50,
            'url': 'https://www.coursera.org/learn/data-analysis-with-python'
          },
          {
            'title': 'Data Visualization',
            'duration': '3 weeks',
            'progress': 20,
            'url': 'https://www.tableau.com/learn/training'
          },
          {
            'title': 'Machine Learning',
            'duration': '6 weeks',
            'progress': 0,
            'url': 'https://www.coursera.org/learn/machine-learning'
          },
          {
            'title': 'Data Science Projects',
            'duration': '4 weeks',
            'progress': 0,
            'url': 'https://www.kaggle.com'
          },
        ];
      case 'Cybersecurity':
        return [
          {
            'title': 'Networking Basics',
            'duration': '4 weeks',
            'progress': 100,
            'url': 'https://www.coursera.org/learn/computer-networking'
          },
          {
            'title': 'Linux Fundamentals',
            'duration': '3 weeks',
            'progress': 40,
            'url': 'https://www.edx.org/learn/linux'
          },
          {
            'title': 'Ethical Hacking',
            'duration': '6 weeks',
            'progress': 0,
            'url':
                'https://www.udemy.com/course/learn-ethical-hacking-from-scratch'
          },
          {
            'title': 'Security Tools',
            'duration': '4 weeks',
            'progress': 0,
            'url': 'https://www.cybrary.it'
          },
          {
            'title': 'CTF Challenges',
            'duration': '4 weeks',
            'progress': 0,
            'url': 'https://ctftime.org'
          },
        ];
      case 'UI/UX':
      case 'UI/UX Design':
        return [
          {
            'title': 'Design Principles',
            'duration': '2 weeks',
            'progress': 100,
            'url': 'https://www.coursera.org/learn/design-principles'
          },
          {
            'title': 'Figma Basics',
            'duration': '3 weeks',
            'progress': 70,
            'url': 'https://www.figma.com/resources/learn-design'
          },
          {
            'title': 'User Research',
            'duration': '3 weeks',
            'progress': 20,
            'url': 'https://www.coursera.org/learn/ux-design'
          },
          {
            'title': 'Prototyping',
            'duration': '4 weeks',
            'progress': 0,
            'url': 'https://www.figma.com'
          },
          {
            'title': 'Portfolio Projects',
            'duration': '4 weeks',
            'progress': 0,
            'url': 'https://www.behance.net'
          },
        ];
      default:
        return [
          {
            'title': 'Programming Basics',
            'duration': '4 weeks',
            'progress': 100,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Data Structures',
            'duration': '4 weeks',
            'progress': 50,
            'url': 'https://www.coursera.org/learn/data-structures'
          },
          {
            'title': 'Algorithms',
            'duration': '4 weeks',
            'progress': 20,
            'url': 'https://www.coursera.org/learn/algorithms-part1'
          },
          {
            'title': 'System Design',
            'duration': '6 weeks',
            'progress': 0,
            'url':
                'https://www.educative.io/courses/grokking-the-system-design-interview'
          },
          {
            'title': 'Real Projects',
            'duration': '4 weeks',
            'progress': 0,
            'url': 'https://github.com'
          },
        ];
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final track = careerTrack ?? 'Software Development';
    final roadmap = _getRoadmap(track);
    final completedSteps = roadmap.where((s) => s['progress'] == 100).length;
    final overallProgress = (completedSteps / roadmap.length * 100).toInt();

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
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              track,
              style: const TextStyle(
                color: AppTheme.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Overall Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        '$overallProgress%',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  StepProgressIndicator(
                    totalSteps: 100,
                    currentStep: overallProgress,
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
                        AppTheme.textSecondary.withOpacity(0.3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$completedSteps of ${roadmap.length} steps completed',
                    style: const TextStyle(
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
              final isDone = step['progress'] == 100;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isDone ? Colors.green : AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isDone
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 18)
                              : Text('${i + 1}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins')),
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 85,
                          color: AppTheme.primary.withOpacity(0.3),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openUrl(step['url']),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: isDone
                                  ? Colors.green.withOpacity(0.3)
                                  : AppTheme.primary.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    step['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${step['progress']}%',
                                      style: TextStyle(
                                        color: isDone
                                            ? Colors.green
                                            : AppTheme.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.open_in_new,
                                      color: AppTheme.textSecondary,
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              step['duration'],
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 8),
                            StepProgressIndicator(
                              totalSteps: 100,
                              currentStep: step['progress'],
                              size: 5,
                              padding: 0,
                              roundedEdges: const Radius.circular(10),
                              selectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isDone
                                    ? [Colors.green, Colors.green.shade300]
                                    : [
                                        AppTheme.primary,
                                        const Color(0xFF9C63FF)
                                      ],
                              ),
                              unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppTheme.surface,
                                  AppTheme.textSecondary.withOpacity(0.2),
                                ],
                              ),
                            ),
                          ],
                        ),
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
