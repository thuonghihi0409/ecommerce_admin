import 'package:flutter/material.dart';

class CustomRatingBar extends StatefulWidget {
  final int starCount;
  final int rating;
  final Function(int)? onRatingChanged;
  final double starSize;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  final bool isReadOnly;

  const CustomRatingBar({
    super.key,
    this.starCount = 5,
    this.rating = 0,
    this.onRatingChanged,
    this.starSize = 24,
    this.spacing = 4,
    this.activeColor = Colors.amber,
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.isReadOnly = false,
  });

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar>
    with SingleTickerProviderStateMixin {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  void _handleTap(int index) {
    if (widget.isReadOnly) return;

    setState(() {
      _currentRating = index + 1;
    });

    widget.onRatingChanged?.call(_currentRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.starCount, (index) {
        final isActive = index < _currentRating;
        return GestureDetector(
          onTap: () => _handleTap(index),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 150),
            scale: isActive ? 1.1 : 1.0,
            curve: Curves.easeInOut,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
              child: Icon(
                Icons.star_rounded,
                size: widget.starSize,
                color: isActive ? widget.activeColor : widget.inactiveColor,
              ),
            ),
          ),
        );
      }),
    );
  }
}
