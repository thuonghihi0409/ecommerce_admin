import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';

class BadgeIcon extends StatelessWidget {
  final Widget icon;
  final int count;
  final VoidCallback? onTap;

  final Color badgeColor;
  final Color badgeTextColor;

  final double badgeSize;
  final double offsetX;
  final double offsetY;

  final int maxCountDisplay;

  const BadgeIcon({
    super.key,
    required this.icon,
    this.count = 0,
    this.onTap,
    this.badgeColor = const Color.fromARGB(255, 250, 3, 3),
    this.badgeTextColor = AppColor.whiteColor,
    this.badgeSize = 12,
    this.offsetX = 0,
    this.offsetY = 0,
    this.maxCountDisplay = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: icon,
          ),
        ),
        if (count > 0)
          Positioned(
            right: offsetX,
            top: -offsetY,
            child: Container(
              height: 25,
              width: 25,
              //padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: badgeColor.withAlpha(200),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                count > maxCountDisplay ? '$maxCountDisplay+' : '$count',
                style: TextStyle(
                  fontSize: badgeSize,
                  color: badgeTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
