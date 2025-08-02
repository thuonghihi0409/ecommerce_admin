import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/quantity_selector_widget.dart';

class AddCartWidget extends StatefulWidget {
  final ProductDetail? productDetail;
  final ProductItem? productItem;
  final String lableButton;
  final Function(ProductItem product, int index, int quantity) onTap;
  const AddCartWidget(
      {super.key,
      required this.productDetail,
      required this.lableButton,
      required this.onTap,
      this.productItem});

  @override
  State<AddCartWidget> createState() => _AddCartWidgetState();
}

class _AddCartWidgetState extends State<AddCartWidget> {
  late int _selectedIndex;
  late int quantity;
  @override
  void initState() {
    super.initState();
    _selectedIndex = (widget.productItem?.productDetail?.variants ?? [])
        .indexWhere((item) => item.id == widget.productItem?.variant?.id);
    if (_selectedIndex < 0) {
      _selectedIndex = 0;
    }
    quantity = widget.productItem?.number ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCacheImageNetwork(
                  imageUrl:
                      widget.productDetail?.variants?[_selectedIndex].cover,
                  height: 120,
                  width: 120,
                  borderRadius: 5,
                ),
                20.w,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                NavigationService.instance.goBack();
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                      Text(
                        Helper.formatCurrencyVND(widget
                            .productDetail?.variants?[_selectedIndex].price),
                        style:
                            AppTextStyles.textSize20(color: AppColor.primary),
                      ),
                      10.h,
                      Text(
                          "${"key_stock".tr()}:${widget.productDetail?.variants?[_selectedIndex].stock ?? 0}")
                    ],
                  ),
                )
              ],
            ),
            10.h,
            const Divider(),
            10.h,
            Text(
              "key_product".tr(),
              style: AppTextStyles.textSize16(),
            ),
            20.h,
            Wrap(
              spacing: 20,
              runSpacing: 20,
              direction: Axis.horizontal,
              children: (widget.productDetail?.variants ?? [])
                  .asMap()
                  .entries
                  .map((item) => InkWell(
                        onTap: () {
                          if (_selectedIndex == item.key) {
                            return;
                          }
                          setState(() {
                            _selectedIndex = item.key;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: item.key == _selectedIndex
                                  ? AppColor.greyColor.withAlpha(120)
                                  : Colors.transparent),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomCacheImageNetwork(
                                imageUrl: item.value.cover,
                                height: 40,
                                width: 30,
                              ),
                              5.w,
                              Text(
                                item.value.name ?? "",
                                style: AppTextStyles.textSize12(),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
            20.h,
            const Divider(),
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "key_quantity".tr(),
                  style: AppTextStyles.textSize12(),
                ),
                QuantitySelector(
                  onChanged: (number) {
                    quantity = number;
                  },
                  initialValue: quantity,
                )
              ],
            ),
            20.h,
          ],
        ),
        CustomButton(
          text: widget.lableButton,
          onPressed: () {
            final item = widget.productItem == null
                ? ProductItem(
                    id: "",
                    productDetail: widget.productDetail,
                    variant: widget.productDetail?.variants?[_selectedIndex],
                    number: quantity)
                : widget.productItem!.copyWith(
                    number: quantity,
                    variant: widget.productDetail?.variants?[_selectedIndex]);
            widget.onTap.call(item, _selectedIndex, quantity);

            NavigationService.instance.goBack();
          },
        ),
        10.h
      ],
    );
  }
}
