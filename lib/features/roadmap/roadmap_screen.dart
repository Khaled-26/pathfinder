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
            'icon': Icons.code_rounded,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Mathematics & Statistics',
            'duration': '6 weeks',
            'progress': 60,
            'icon': Icons.calculate_rounded,
            'url': 'https://www.khanacademy.org/math/statistics-probability'
          },
          {
            'title': 'Machine Learning',
            'duration': '8 weeks',
            'progress': 30,
            'icon': Icons.psychology_rounded,
            'url': 'https://www.coursera.org/learn/machine-learning'
          },
          {
            'title': 'Deep Learning',
            'duration': '8 weeks',
            'progress': 0,
            'icon': Icons.memory_rounded,
            'url': 'https://www.coursera.org/specializations/deep-learning'
          },
          {
            'title': 'AI Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.rocket_launch_rounded,
            'url': 'https://www.kaggle.com'
          },
        ];
      case 'Data Science':
        return [
          {
            'title': 'Python & SQL',
            'duration': '4 weeks',
            'progress': 100,
            'icon': Icons.code_rounded,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Data Analysis',
            'duration': '4 weeks',
            'progress': 50,
            'icon': Icons.bar_chart_rounded,
            'url': 'https://www.coursera.org/learn/data-analysis-with-python'
          },
          {
            'title': 'Data Visualization',
            'duration': '3 weeks',
            'progress': 20,
            'icon': Icons.pie_chart_rounded,
            'url': 'https://www.tableau.com/learn/training'
          },
          {
            'title': 'Machine Learning',
            'duration': '6 weeks',
            'progress': 0,
            'icon': Icons.psychology_rounded,
            'url': 'https://www.coursera.org/learn/machine-learning'
          },
          {
            'title': 'Data Science Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.rocket_launch_rounded,
            'url': 'https://www.kaggle.com'
          },
        ];
      case 'Cybersecurity':
        return [
          {
            'title': 'Networking Basics',
            'duration': '4 weeks',
            'progress': 100,
            'icon': Icons.network_check_rounded,
            'url': 'https://www.coursera.org/learn/computer-networking'
          },
          {
            'title': 'Linux Fundamentals',
            'duration': '3 weeks',
            'progress': 40,
            'icon': Icons.terminal_rounded,
            'url': 'https://www.edx.org/learn/linux'
          },
          {
            'title': 'Ethical Hacking',
            'duration': '6 weeks',
            'progress': 0,
            'icon': Icons.bug_report_rounded,
            'url':
                'https://www.udemy.com/course/learn-ethical-hacking-from-scratch'
          },
          {
            'title': 'Security Tools',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.security_rounded,
            'url': 'https://www.cybrary.it'
          },
          {
            'title': 'CTF Challenges',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.flag_rounded,
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
            'icon': Icons.palette_rounded,
            'url': 'https://www.coursera.org/learn/design-principles'
          },
          {
            'title': 'Figma Basics',
            'duration': '3 weeks',
            'progress': 70,
            'icon': Icons.design_services_rounded,
            'url': 'https://www.figma.com/resources/learn-design'
          },
          {
            'title': 'User Research',
            'duration': '3 weeks',
            'progress': 20,
            'icon': Icons.people_rounded,
            'url': 'https://www.coursera.org/learn/ux-design'
          },
          {
            'title': 'Prototyping',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.phone_android_rounded,
            'url': 'https://www.figma.com'
          },
          {
            'title': 'Portfolio Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.work_rounded,
            'url': 'https://www.behance.net'
          },
        ];
      default:
        return [
          {
            'title': 'Programming Basics',
            'duration': '4 weeks',
            'progress': 100,
            'icon': Icons.code_rounded,
            'url': 'https://www.coursera.org/learn/python'
          },
          {
            'title': 'Data Structures',
            'duration': '4 weeks',
            'progress': 50,
            'icon': Icons.account_tree_rounded,
            'url': 'https://www.coursera.org/learn/data-structures'
          },
          {
            'title': 'Algorithms',
            'duration': '4 weeks',
            'progress': 20,
            'icon': Icons.analytics_rounded,
            'url': 'https://www.coursera.org/learn/algorithms-part1'
          },
          {
            'title': 'System Design',
            'duration': '6 weeks',
            'progress': 0,
            'icon': Icons.architecture_rounded,
            'url':
                'https://www.educative.io/courses/grokking-the-system-design-interview'
          },
          {
            'title': 'Real Projects',
            'duration': '4 weeks',
            'progress': 0,
            'icon': Icons.rocket_launch_rounded,
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
        return const Color(0xFF00897B);
      case 'Cybersecurity':
        return const Color(0xFFF57C00);
      case 'UI/UX Design':
      case 'UI/UX':
        return AppTheme.primary;
      case 'Software Development':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF2E7D32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final track = careerTrack ?? 'Software Development';
    final roadmap = _getRoadmap(track);
    final completedSteps = roadmap.where((s) => s['progress'] == 100).length;
    final overallProgress = (completedSteps / roadmap.length * 100).toInt();
    final trackColor = _getTrackColor(track);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: trackColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.map_rounded, color: trackColor, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Learning Roadmap',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: trackColor.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: trackColor.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    )
                  ],
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
                            const Text('Overall Progress',
                                style: TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Poppins')),
                            Text(
                                '$completedSteps of ${roadmap.length} steps completed',
                                style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 11,
                                    fontFamily: 'Poppins')),
                          ],
                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: trackColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text('$overallProgress%',
                                style: TextStyle(
                                    color: trackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Poppins')),
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
                        colors: [AppTheme.border, AppTheme.border],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const Text('Your Learning Path',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins')),
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
                    : isInProgress
                        ? trackColor
                        : AppTheme.textSecondary;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline
                    Column(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: isDone
                                ? Colors.green
                                : isInProgress
                                    ? trackColor
                                    : AppTheme.background,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDone
                                  ? Colors.green
                                  : isInProgress
                                      ? trackColor
                                      : AppTheme.border,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: isDone
                                ? const Icon(Icons.check_rounded,
                                    color: Colors.white, size: 20)
                                : Text('${i + 1}',
                                    style: TextStyle(
                                      color: isInProgress
                                          ? Colors.white
                                          : AppTheme.textSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    )),
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
                                  stepColor.withOpacity(0.4),
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
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isDone
                                  ? Colors.green.withOpacity(0.3)
                                  : isInProgress
                                      ? trackColor.withOpacity(0.3)
                                      : AppTheme.border,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDone || isInProgress
                                    ? (isDone ? Colors.green : trackColor)
                                        .withOpacity(0.08)
                                    : Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: (isDone
                                              ? Colors.green
                                              : isInProgress
                                                  ? trackColor
                                                  : AppTheme.textSecondary)
                                          .withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      step['icon'] as IconData,
                                      color: isDone
                                          ? Colors.green
                                          : isInProgress
                                              ? trackColor
                                              : AppTheme.textSecondary,
                                      size: 20,
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
                                                ? AppTheme.textPrimary
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
                                      Icon(Icons.open_in_new_rounded,
                                          color: AppTheme.textSecondary
                                              .withOpacity(0.4),
                                          size: 12),
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
                                      : [
                                          trackColor,
                                          trackColor.withOpacity(0.6)
                                        ],
                                ),
                                unselectedGradientColor: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFEEEEEE),
                                    Color(0xFFEEEEEE)
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
      ),
    );
  }
}
