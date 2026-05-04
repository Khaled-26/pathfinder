import 'package:flutter/material.dart';
import 'package:pathfinder/core/theme/app_theme.dart';
import 'package:pathfinder/features/result/result_screen.dart';
import 'package:pathfinder/shared/widgets/notification_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  final Map<String, int> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Do you enjoy working with data and statistics?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'data',
      'icon': Icons.bar_chart,
    },
    {
      'question': 'How much do you enjoy building and coding applications?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'coding',
      'icon': Icons.code,
    },
    {
      'question': 'Are you interested in cybersecurity and protecting systems?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'security',
      'icon': Icons.security,
    },
    {
      'question': 'Do you enjoy designing user interfaces and experiences?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'design',
      'icon': Icons.design_services,
    },
    {
      'question': 'Are you fascinated by AI and machine learning?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'ai',
      'icon': Icons.psychology,
    },
  ];

  void _answer(int value) {
    setState(() {
      _answers[_questions[_currentQuestion]['key']] = value;
    });

    if (_currentQuestion < _questions.length - 1) {
      setState(() => _currentQuestion++);
    } else {
      NotificationService.showNotification(
        context: context,
        title: '🎉 Quiz Completed!',
        body: 'Check your career recommendation now!',
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(answers: _answers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];
    final progress = (_currentQuestion + 1) / _questions.length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.quiz, color: AppTheme.primary),
                SizedBox(width: 8),
                Text(
                  'Skill Assessment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Question ${_currentQuestion + 1} of ${_questions.length}',
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppTheme.surface,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(
                    question['icon'] as IconData,
                    color: AppTheme.primary,
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question['question'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            ...List.generate(
              (question['options'] as List).length,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => _answer(i),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppTheme.primary.withOpacity(0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + i),
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          (question['options'] as List)[i],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
