import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class StoreInfoWidget extends StatelessWidget {
  final Store? store;
  const StoreInfoWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          CustomCacheImageNetwork(
            width: double.infinity,
            imageUrl: store?.backgroundUrl ?? "",
            boxFit: BoxFit.fill,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColor.greyColor.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: CustomCacheImageNetwork(
                      imageUrl: store?.logoUrl,
                      height: 80,
                      width: 80,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  10.w,
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store?.name ?? "",
                          style: AppTextStyles.textSize20(),
                        ),
                        5.h,
                        Text(
                          store?.address ?? "",
                          style: AppTextStyles.textSize12(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
