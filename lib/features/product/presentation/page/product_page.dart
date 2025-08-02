import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/product/presentation/page/product_detail_page.dart';
import 'package:thuongmaidientu/features/product/presentation/widget/product_card.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _filters = [
    {"label": "Tất cả", "max": null, "min": null},
    {"label": "Dưới 1 triệu", "max": 1000000, "min": null},
    {"label": "1 triệu - 2 triệu", "max": 2000000, "min": 1000000},
    {"label": "2 triệu  - 5 triệu", "max": 5000000, "min": 2000001},
    {"label": "Trên 5 triệu", "max": null, "min": 5000001},
  ];
  int? _max, _min;
  int _selectCategory = -1;
  String? _categoryId;
  String? _search;

  @override
  void initState() {
    super.initState();
    _getDate();
    context.read<ProductBloc>().add(const GetListCategory());
  }

  _getDate({bool isLoading = true}) async {
    context.read<ProductBloc>().add(GetListProduct(
        search: _search,
        categoryId: _categoryId,
        isLoading: isLoading,
        maxPrice: _categoryId != null ? _max : null,
        minPrice: _categoryId != null ? _min : null,
        storeId: null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.greyColor.withAlpha(20),
        appBar: CustomAppBar(
          customTitle: CustomSearchField(
            onSearchChanged: (search) {
              _search = search;
              _getDate();
            },
          ),
          showLeading: false,
        ),
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              children: [
                5.h,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: (state.listCategory ??
                              [
                               
                              ])
                          .asMap()
                          .entries
                          .map((e) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: _selectCategory == e.key
                                        ? AppColor.primary.withAlpha(50)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5)),
                                child: InkWell(
                                  onTap: () {
                                    if (_selectCategory != e.key) {
                                      setState(() {
                                        _selectCategory = e.key;
                                        _categoryId = e.value.id;
                                        _getDate();
                                      });
                                    } else {
                                      setState(() {
                                        _selectCategory = -1;
                                        _categoryId = null;
                                        _getDate();
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Column(
                                      children: [
                                        CustomCacheImageNetwork(
                                          height: 100,
                                          width: 80,
                                          borderRadius: 5,
                                          imageUrl: e.value.cover,
                                          isShowLoading: false,
                                        ),
                                        Text(
                                          e.value.name ?? "",
                                          style: AppTextStyles.textSize12(),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList()),
                ),
                if (_selectCategory >= 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 100,
                        child: DropdownSearch<Map<String, dynamic>>(
                          popupProps: const PopupProps.bottomSheet(),
                          suffixProps: const DropdownSuffixProps(
                            dropdownButtonProps: DropdownButtonProps(
                              isVisible: false,
                            ),
                          ),
                          dropdownBuilder: (context, filter) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  filter != null
                                      ? filter["label"].toString()
                                      : "",
                                  style: AppTextStyles.textSize10(),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 20,
                              )
                            ],
                          ),
                          itemAsString: (item) => item["label"].toString(),
                          items: (filter, loadProps) => _filters,
                          compareFn: (item1, item2) {
                            return item1 != item2;
                          },
                          decoratorProps: DropDownDecoratorProps(
                            decoration: InputDecoration(
                                filled: true,
                                hint: Text(
                                  "key_price".tr(),
                                  style: AppTextStyles.textSize10(),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 0.5, color: AppColor.primary)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5, color: AppColor.greyColor)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.5,
                                        color: AppColor.greyColor))),
                          ),
                          onChanged: (value) {
                            _min = value?["min"];
                            _max = value?["max"];
                            _getDate(isLoading: false);
                          },
                        ),
                      ),
                      10.w
                    ],
                  ),
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: state.listProduct.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product = state.listProduct.results?[index];
                      return ProductCard(
                          product: product!,
                          onTap: () {
                            NavigationService.instance
                                .push(ProductDetailPage(product: product));
                          });
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
