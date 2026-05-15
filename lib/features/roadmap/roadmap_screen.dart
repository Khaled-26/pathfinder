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
            'icon': Icons.code,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Mathematics & Statistics',
            'duration': '6 weeks',
            'progress': 60,
            'icon': Icons.calculate,
            'url': 'https://www.khanacademy.org/math/statistics-probability'
          },
          {
            'title': 'Machine Learning',
            'duration': '8 weeks',
            'progress': 30,
            'icon': Icons.psychology,
            'url': 'https://www.coursera.org/learn/machine-learning'
          },
          {
            'title': 'Deep Learning',
            'duration': '8 weeks',
            'progress': 0,
            'icon': Icons.memory,
            'url': 'https://www.coursera.org/specializations/deep-learning'
          },
          {
            'title': 'AI Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.rocket_launch,
            'url': 'https://www.kaggle.com'
          },
        ];
      case 'Data Science':
        return [
          {
            'title': 'Python & SQL',
            'duration': '4 weeks',
            'progress': 100,
            'icon': Icons.code,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Data Analysis',
            'duration': '4 weeks',
            'progress': 50,
            'icon': Icons.bar_chart,
            'url': 'https://www.coursera.org/learn/data-analysis-with-python'
          },
          {
            'title': 'Data Visualization',
            'duration': '3 weeks',
            'progress': 20,
            'icon': Icons.pie_chart,
            'url': 'https://www.tableau.com/learn/training'
          },
          {
            'title': 'Machine Learning',
            'duration': '6 weeks',
            'progress': 0,
            'icon': Icons.psychology,
            'url': 'https://www.coursera.org/learn/machine-learning'
          },
          {
            'title': 'Data Science Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.rocket_launch,
            'url': 'https://www.kaggle.com'
          },
        ];
      case 'Cybersecurity':
        return [
          {
            'title': 'Networking Basics',
            'duration': '4 weeks',
            'progress': 100,
            'icon': Icons.network_check,
            'url': 'https://www.coursera.org/learn/computer-networking'
          },
          {
            'title': 'Linux Fundamentals',
            'duration': '3 weeks',
            'progress': 40,
            'icon': Icons.terminal,
            'url': 'https://www.edx.org/learn/linux'
          },
          {
            'title': 'Ethical Hacking',
            'duration': '6 weeks',
            'progress': 0,
            'icon': Icons.bug_report,
            'url':
                'https://www.udemy.com/course/learn-ethical-hacking-from-scratch'
          },
          {
            'title': 'Security Tools',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.security,
            'url': 'https://www.cybrary.it'
          },
          {
            'title': 'CTF Challenges',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.flag,
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
            'icon': Icons.palette,
            'url': 'https://www.coursera.org/learn/design-principles'
          },
          {
            'title': 'Figma Basics',
            'duration': '3 weeks',
            'progress': 70,
            'icon': Icons.design_services,
            'url': 'https://www.figma.com/resources/learn-design'
          },
          {
            'title': 'User Research',
            'duration': '3 weeks',
            'progress': 20,
            'icon': Icons.people,
            'url': 'https://www.coursera.org/learn/ux-design'
          },
          {
            'title': 'Prototyping',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.phone_android,
            'url': 'https://www.figma.com'
          },
          {
            'title': 'Portfolio Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.work,
            'url': 'https://www.behance.net'
          },
        ];
      default:
        return [
          {
            'title': 'Programming Basics',
            'duration': '4 weeks',
            'progress': 100,
            'icon': Icons.code,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Data Structures',
            'duration': '4 weeks',
            'progress': 50,
            'icon': Icons.account_tree,
            'url': 'https://www.coursera.org/learn/data-structures'
          },
          {
            'title': 'Algorithms',
            'duration': '4 weeks',
            'progress': 20,
            'icon': Icons.analytics,
            'url': 'https://www.coursera.org/learn/algorithms-part1'
          },
          {
            'title': 'System Design',
            'duration': '6 weeks',
            'progress': 0,
            'icon': Icons.architecture,
            'url':
                'https://www.educative.io/courses/grokking-the-system-design-interview'
          },
          {
            'title': 'Real Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.rocket_launch,
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

  Color _getTrackColor(String track) {
    switch (track) {
      case 'Artificial Intelligence':
        return const Color(0xFF6C63FF);
      case 'Data Science':
        return const Color(0xFF03DAC6);
      case 'Cybersecurity':
        return const Color(0xFFFFB347);
      case 'UI/UX Design':
      case 'UI/UX':
        return const Color(0xFFE91E63);
      case 'Software Development':
        return const Color(0xFFFF6584);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  @override
  Widget build(BuildContext context) {
    final track = careerTrack ?? 'Software Development';
    final roadmap = _getRoadmap(track);
    final completedSteps = roadmap.where((s) => s['progress'] == 100).length;
    final overallProgress = (completedSteps / roadmap.length * 100).toInt();
    final trackColor = _getTrackColor(track);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: trackColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.map, color: trackColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Learning Roadmap',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        track,
                        style: TextStyle(
                          color: trackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Overall Progress Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    trackColor.withOpacity(0.2),
                    trackColor.withOpacity(0.05)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: trackColor.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Overall Progress',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            '$completedSteps of ${roadmap.length} steps completed',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: trackColor.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$overallProgress%',
                            style: TextStyle(
                              color: trackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  StepProgressIndicator(
                    totalSteps: 100,
                    currentStep: overallProgress,
                    size: 10,
                    padding: 0,
                    roundedEdges: const Radius.circular(10),
                    selectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [trackColor, trackColor.withOpacity(0.6)],
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
            const SizedBox(height: 24),

            const Text(
              'Your Learning Path',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),

            // Steps
            ...List.generate(roadmap.length, (i) {
              final step = roadmap[i];
              final isLast = i == roadmap.length - 1;
              final isDone = step['progress'] == 100;
              final isInProgress =
                  step['progress'] > 0 && step['progress'] < 100;
              final stepColor = isDone
                  ? Colors.green
                  : (isInProgress ? trackColor : AppTheme.textSecondary);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDone
                              ? Colors.green
                              : isInProgress
                                  ? trackColor
                                  : AppTheme.surface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDone
                                ? Colors.green
                                : isInProgress
                                    ? trackColor
                                    : AppTheme.textSecondary.withOpacity(0.4),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: isDone
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 20)
                              : Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    color: isInProgress
                                        ? Colors.white
                                        : AppTheme.textSecondary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 90,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                stepColor.withOpacity(0.6),
                                stepColor.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 14),

                  // Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _openUrl(step['url']),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDone
                                ? Colors.green.withOpacity(0.4)
                                : isInProgress
                                    ? trackColor.withOpacity(0.4)
                                    : AppTheme.textSecondary.withOpacity(0.15),
                          ),
                          boxShadow: isDone || isInProgress
                              ? [
                                  BoxShadow(
                                    color: (isDone ? Colors.green : trackColor)
                                        .withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : [],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: (isDone
                                            ? Colors.green
                                            : isInProgress
                                                ? trackColor
                                                : AppTheme.textSecondary)
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    step['icon'] as IconData,
                                    color: isDone
                                        ? Colors.green
                                        : isInProgress
                                            ? trackColor
                                            : AppTheme.textSecondary,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        step['title'],
                                        style: TextStyle(
                                          color: isDone || isInProgress
                                              ? Colors.white
                                              : AppTheme.textSecondary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        step['duration'],
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 11,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${step['progress']}%',
                                      style: TextStyle(
                                        color: isDone
                                            ? Colors.green
                                            : isInProgress
                                                ? trackColor
                                                : AppTheme.textSecondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    Icon(
                                      Icons.open_in_new,
                                      color: AppTheme.textSecondary
                                          .withOpacity(0.5),
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
                                    : [trackColor, trackColor.withOpacity(0.6)],
                              ),
                              unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppTheme.surface,
                                  AppTheme.textSecondary.withOpacity(0.15),
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
