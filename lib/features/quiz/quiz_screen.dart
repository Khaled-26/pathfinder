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
  int? _selectedOption;
  final Map<String, int> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Do you enjoy working with data and statistics?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'data',
      'icon': Icons.bar_chart_rounded,
      'color': Color(0xFF00897B),
    },
    {
      'question': 'How much do you enjoy building and coding applications?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'coding',
      'icon': Icons.code_rounded,
      'color': Color(0xFFE53935),
    },
    {
      'question': 'Are you interested in cybersecurity and protecting systems?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'security',
      'icon': Icons.security_rounded,
      'color': Color(0xFFF57C00),
    },
    {
      'question': 'Do you enjoy designing user interfaces and experiences?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'design',
      'icon': Icons.design_services_rounded,
      'color': AppTheme.primary,
    },
    {
      'question': 'Are you fascinated by AI and machine learning?',
      'options': ['Not at all', 'A little', 'Quite a bit', 'Very much'],
      'key': 'ai',
      'icon': Icons.psychology_rounded,
      'color': Color(0xFF6C63FF),
    },
  ];

  void _answer(int value) {
    setState(() => _selectedOption = value);
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _answers[_questions[_currentQuestion]['key']] = value;
        _selectedOption = null;
      });
      if (_currentQuestion < _questions.length - 1) {
        setState(() => _currentQuestion++);
      } else {
        NotificationService.showNotification(
          context: context,
          title: '🎉 Quiz Completed!',
          body: 'Check your career recommendation now!',
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ResultScreen(answers: _answers)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];
    final questionColor = question['color'] as Color;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: questionColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.quiz_rounded,
                        color: questionColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Skill Assessment',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                          )),
                      Text(
                          'Question ${_currentQuestion + 1} of ${_questions.length}',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Progress
              Row(
                children: List.generate(
                    _questions.length,
                    (i) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: 6,
                            decoration: BoxDecoration(
                              color: i <= _currentQuestion
                                  ? questionColor
                                  : AppTheme.border,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        )),
              ),
              const SizedBox(height: 28),

              // Question Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: questionColor.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                        color: questionColor.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: questionColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(question['icon'] as IconData,
                          color: questionColor, size: 32),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question['question'],
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        height: 1.5,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Options
              Expanded(
                child: ListView.builder(
                  itemCount: (question['options'] as List).length,
                  itemBuilder: (context, i) {
                    final isSelected = _selectedOption == i;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _answer(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? questionColor.withOpacity(0.1)
                                : AppTheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  isSelected ? questionColor : AppTheme.border,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? questionColor.withOpacity(0.15)
                                    : Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? questionColor
                                      : AppTheme.background,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? questionColor
                                        : AppTheme.border,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + i),
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : AppTheme.textSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                (question['options'] as List)[i],
                                style: TextStyle(
                                  color: isSelected
                                      ? questionColor
                                      : AppTheme.textPrimary,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
