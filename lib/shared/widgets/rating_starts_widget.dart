import 'package:flutter/material.dart';

class RatingStarsWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color filledColor;
  final Color emptyColor;

  const RatingStarsWidget({
    super.key,
    required this.rating,
    this.size = 18,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final filled = index + 1 <= rating;
        final partial = (index + 1 > rating && index < rating);

        return Stack(
          children: [
            Icon(Icons.star, color: emptyColor, size: size),
            if (filled)
              Icon(Icons.star, color: filledColor, size: size)
            else if (partial)
              ClipRect(
                clipper: _StarClipper(rating - index),
                child: Icon(Icons.star, color: filledColor, size: size),
              ),
          ],
        );
      }),
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double clipFactor;

  _StarClipper(this.clipFactor);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * clipFactor, size.height);
  }

  @override
  bool shouldReclip(_StarClipper oldClipper) {
    return clipFactor != oldClipper.clipFactor;
  }
}
