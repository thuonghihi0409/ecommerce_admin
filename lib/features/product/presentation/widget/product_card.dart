import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                  aspectRatio: 1.1,
                  child: CustomCacheImageNetwork(imageUrl: product.cover)),
            ),
            8.h,

            // Product Name
            Text(
              product.productName ?? "",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            5.h,
            Row(
              children: [
                Text("${product.avgRating}", style: AppTextStyles.textSize14()),
                3.w,
                const Icon(
                  Icons.star_half,
                  color: AppColor.yellowColor,
                  size: 28,
                ),
              ],
            ),
            5.h,

            // Product Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Helper.formatCurrencyVND(product.price),
                    style: AppTextStyles.textSize14(color: AppColor.primary)),
                Text(
                  "${"key_solded".tr()} ${Helper.formatNumber(
                    product.totalSold ?? 0,
                  )}",
                  style: AppTextStyles.textSize12(
                      color: AppColor.greyColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
