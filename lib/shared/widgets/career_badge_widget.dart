import 'package:flutter/material.dart';

/// CareerBadgeWidget - Custom Widget by PathFinder Team
/// Ain Shams University - Software Engineering
class CareerBadgeWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? progress;
  final bool showProgress;

  const CareerBadgeWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    this.isSelected = false,
    this.onTap,
    this.progress,
    this.showProgress = false,
  });

  @override
  State<CareerBadgeWidget> createState() => _CareerBadgeWidgetState();
}

class _CareerBadgeWidgetState extends State<CareerBadgeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? widget.color.withOpacity(0.15)
                  : const Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.isSelected
                    ? widget.color
                    : widget.color.withOpacity(0.3),
                width: widget.isSelected ? 2 : 1,
              ),
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                        color: widget.color.withOpacity(0.25),
                        blurRadius: 16,
                        spreadRadius: 1,
                      )
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.isSelected ? Colors.white : Colors.white70,
                    fontWeight:
                        widget.isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 11,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.showProgress && widget.progress != null) ...[
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: widget.progress!,
                      backgroundColor: widget.color.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                      minHeight: 4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
