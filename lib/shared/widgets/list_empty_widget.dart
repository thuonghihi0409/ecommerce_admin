import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';

class ListEmptyWidget extends StatelessWidget {
  final String title;
  final String icon;
  const ListEmptyWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SvgPicture.asset(
        height: 100,
        width: 100,
        icon,
        colorFilter:
            const ColorFilter.mode(Colors.greenAccent, BlendMode.srcIn),
      ),
      50.h,
      Text(
        textAlign: TextAlign.center,
        title,
        style: AppTextStyles.textSize16(),
      )
    ]);
  }
}
