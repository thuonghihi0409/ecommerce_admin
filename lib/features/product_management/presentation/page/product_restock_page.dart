import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product_management/domain/entities/variant_input.dart';
import 'package:thuongmaidientu/features/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class ProductRestockPage extends StatefulWidget {
  const ProductRestockPage({super.key});

  @override
  State<ProductRestockPage> createState() => _ProductRestockPageState();
}

class _ProductRestockPageState extends State<ProductRestockPage> {
  List<VariantInput> variantInputs = [];

  int? samePriceValue;

  void applySameStock() {
    if (samePriceValue != null) {
      for (var input in variantInputs) {
        input.controller.text = samePriceValue.toString();
      }
    }
    setState(() {});
  }

  void onSubmit() {
    context.read<ProductManagementBloc>().add(SellerUpdateVariant(
        variants: variantInputs
            .map((item) => Variant(
                id: item.id,
                name: item.name,
                price: item.price,
                stock: item.stock + (int.tryParse(item.controller.text) ?? 0),
                cover: item.cover,
                totalSold: 0))
            .toList(),
        onSuccess: () {
          NavigationService.instance.pushNamed('product_management');
        }));
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget: BlocBuilder<ProductManagementBloc, ProductManagementState>(
          builder: (context, state) {
        return CustomLoading(
          isOverlay: true,
          isLoading: state.isGetDetail,
        );
      }),
      child: BlocBuilder<ProductManagementBloc, ProductManagementState>(
          builder: (context, state) {
        if (state.isGetDetail) {
          return const SizedBox();
        }
        variantInputs = (state.productDetailModel?.variants ?? [])
            .map((variant) => VariantInput(
                id: variant.id,
                name: variant.name ?? "",
                price: variant.price ?? 0,
                stock: variant.stock ?? 0,
                cover: variant.cover))
            .toList();
        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          appBar: CustomAppBar(
            isShowCartIcon: false,
            isShowChatIcon: false,
            title: state.productDetailModel?.productName ?? "",
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'key_restock_for_all_variant'.tr(),
                  style: AppTextStyles.textSize16(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      hintText: 'key_enter_quantity'.tr(),
                      onChanged: (value) =>
                          samePriceValue = int.tryParse(value),
                      keyboardType: TextInputType.number,
                    )),
                    Expanded(
                        child: Center(
                      child: CustomButton(
                        text: "key_apply".tr(),
                        onPressed: applySameStock,
                        isMinWidth: true,
                      ),
                    ))
                  ],
                ),
                30.h,
                Expanded(
                  child: ListView.builder(
                    itemCount: variantInputs.length,
                    itemBuilder: (context, index) {
                      final item = variantInputs[index];
                      return Card(
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CustomCacheImageNetwork(
                                imageUrl: item.cover,
                                height: 150,
                                width: 150,
                                borderRadius: 20,
                              ),
                              20.w,
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: AppTextStyles.textSize20(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    10.h,
                                    Text(
                                      '${"key_price".tr()}: ${Helper.formatCurrencyVND(item.price.toString())}',
                                      style: AppTextStyles.textSize16(),
                                    ),
                                    10.h,
                                    Text(
                                        '${"key_stock".tr()}: ${item.stock.toString()}',
                                        style: AppTextStyles.textSize16()),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: CustomTextField(
                                    controller: item.controller,
                                    labelText: "key_enter_quantity".tr(),
                                    keyboardType: TextInputType.number,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                20.h,
                CustomButton(
                  text: "key_confirm_restock".tr(),
                  onPressed: onSubmit,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
