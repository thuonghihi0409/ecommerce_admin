import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';

class ListOrderEmptyWidget extends StatelessWidget {
  const ListOrderEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SvgPicture.asset(
        height: 100,
        width: 100,
        AppAssets.orderIcon,
        colorFilter:
            const ColorFilter.mode(Colors.greenAccent, BlendMode.srcIn),
      ),
      50.h,
      Text(
        "key_no_order".tr(),
        style: AppTextStyles.textSize16(),
      )
    ]);
  }
}
