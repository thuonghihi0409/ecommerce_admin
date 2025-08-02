import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class ReviewItemWidget extends StatefulWidget {
  final Review? review;
  const ReviewItemWidget({super.key, required this.review});

  @override
  State<ReviewItemWidget> createState() => _ReviewItemWidgetState();
}

class _ReviewItemWidgetState extends State<ReviewItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final review = widget.review;
    final images = review?.imageUrls ?? [];

    final displayedImages = isExpanded ? images : images.take(3).toList();
    final showExpandButton = images.length > 3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomCacheImageNetwork(
                imageUrl: review?.user?.image,
                height: 40,
                width: 40,
              ),
              10.w,
              Expanded(
                child: Text(
                  review?.user?.name ?? "",
                  style: AppTextStyles.textSize14(),
                ),
              ),
              Text(
                DateFormat("dd/MM/yyyy")
                    .format(review?.createdAt ?? DateTime.now()),
                style: AppTextStyles.textSize14(),
              ),
            ],
          ),
          10.h,
          Row(
            children: List.generate(
              review?.rating ?? 0,
              (_) =>
                  const Icon(Icons.star, color: AppColor.yellowColor, size: 14),
            ),
          ),
          20.h,
          Text(
            "${"key_variant".tr()}: ${review?.variant?.name ?? ""}",
            style: AppTextStyles.textSize16(color: AppColor.greyColor),
          ),
          10.h,
          Text(
            review?.content ?? "",
            style: AppTextStyles.textSize14(),
          ),
          10.h,
          if (images.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: displayedImages.map((url) {
                return GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CustomCacheImageNetwork(
                      imageUrl: url,
                      height: 110,
                      width: 110,
                    ),
                  ),
                );
              }).toList(),
            ),
            if (showExpandButton)
              TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? "Thu gọn" : "Xem thêm",
                  style: const TextStyle(color: AppColor.primary),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
