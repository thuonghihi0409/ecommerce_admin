import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/product/presentation/page/store_detail.dart';
import 'package:thuongmaidientu/features/product/presentation/widget/product_card.dart';
import 'package:thuongmaidientu/features/review/presentation/page/review_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_carausel_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context.read<ProductBloc>().add(GetProductDetail(
        productId: widget.product.productId,
        categoryId: widget.product.categoryId ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        return CustomLoading(
          isLoading: state.isGetDetail,
          isOverlay: true,
        );
      }),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          title: "key_product_detail".tr(),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCarousel(
                            imageUrls: state.productDetailModel?.images ?? []),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      (state.productDetailModel?.variants ?? [])
                                          .length,
                                  itemBuilder: (context, index) {
                                    final variant =
                                        (state.productDetailModel!.variants ??
                                            [])[index];
                                    return CustomCacheImageNetwork(
                                      borderRadius: 5,
                                      imageUrl: variant.cover,
                                      height: 80,
                                      width: 70,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                ),
                              ),
                              10.h,
                              Text(
                                Helper.formatCurrencyVND(
                                    state.productDetailModel?.price),
                                style: AppTextStyles.textSize20(
                                    color: AppColor.primary),
                              ),
                              10.h,
                              Text(
                                state.productDetailModel?.productName ?? "",
                                style: AppTextStyles.textSize16(),
                              ),
                              5.h,
                              Text(
                                state.productDetailModel?.description ?? "",
                                style: AppTextStyles.textSize14(),
                              ),
                              5.h,
                              Text(
                                "${"key_solded".tr()} ${Helper.formatNumber(state.productDetailModel?.totalSold ?? 0)}",
                                style: AppTextStyles.textSize16(
                                    color: AppColor.greyColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              10.h
                            ],
                          ),
                        ),
                        Container(
                          height: 5,
                          color: AppColor.greyColor.withAlpha(50),
                        ),
                        10.h,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              NavigationService.instance.push(ReviewPage(
                                productDetail: state.productDetailModel,
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (state.productDetailModel?.avgRating ?? 0)
                                          .toString(),
                                      style: AppTextStyles.textSize18(),
                                    ),
                                    const Icon(
                                      Icons.star_half,
                                      color: AppColor.yellowColor,
                                      size: 28,
                                    ),
                                    Text(
                                      "${"key_review".tr()}(${Helper.formatNumber(state.productDetailModel?.totalRating ?? 0)})",
                                      style: AppTextStyles.textSize18(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "key_view_all".tr(),
                                      style: AppTextStyles.textSize16(),
                                    ),
                                    5.w,
                                    const Icon(Icons.chevron_right)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        10.h,
                        Container(
                          height: 5,
                          color: AppColor.greyColor.withAlpha(50),
                        ),
                        10.h,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    child: CustomCacheImageNetwork(
                                      imageUrl: state
                                          .productDetailModel?.store?.logoUrl,
                                      height: 80,
                                      width: 80,
                                      boxFit: BoxFit.fill,
                                    ),
                                  ),
                                  10.w,
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.productDetailModel?.store
                                                  ?.name ??
                                              "",
                                          style: AppTextStyles.textSize20(),
                                        ),
                                        5.h,
                                        Text(
                                          state.productDetailModel?.store
                                                  ?.address ??
                                              "",
                                          style: AppTextStyles.textSize12(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.w,
                                  Expanded(
                                      flex: 1,
                                      child: CustomButton(
                                        borderColor: AppColor.primary,
                                        padding: const EdgeInsets.all(5),
                                        borderRadius: 2,
                                        height: 40,
                                        text: "key_view_store".tr(),
                                        textStyle: AppTextStyles.textSize10(),
                                        backgroundColor:
                                            AppColor.greyColor.withAlpha(150),
                                        onPressed: () {
                                          NavigationService.instance
                                              .push(StoreDetail(
                                            store:
                                                state.productDetailModel?.store,
                                          ));
                                        },
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        20.h,
                        Center(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: (state.productSummerice ?? [])
                                .map((item) => SizedBox(
                                      width: context.widthScreen * 0.47,
                                      child: ProductCard(
                                          product: item,
                                          onTap: () {
                                            // NavigationService.instance.replace(
                                            //     ProductDetailPage(product: item));
                                          }),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
