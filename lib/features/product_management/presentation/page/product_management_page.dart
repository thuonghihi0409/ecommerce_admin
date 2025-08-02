import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/features/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/rating_starts_widget.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final int _selectCategory = -1;
  late ProductDataSource _dataSource;
  List<SellerProduct> _products = [];

  String _searchQuery = '';
  late ProductManagementBloc _productManagementBloc;
  @override
  void initState() {
    super.initState();
    _productManagementBloc = context.read<ProductManagementBloc>();
    _getDate();
  }

  _getDate() async {
    _productManagementBloc
      ..add(const SellerGetListProduct())
      ..add(const SellerGetListCategory());
  }

  void _filterSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      final filtered = _products
          .where(
              (p) => (p.productName ?? "").toLowerCase().contains(_searchQuery))
          .toList();
      _dataSource.updateData(filtered);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductManagementBloc, ProductManagementState>(
      builder: (context, state) {
        _products = state.listProduct.results ?? [];
        _dataSource = ProductDataSource(_products, _productManagementBloc);

        return Scaffold(
          backgroundColor: AppColor.greyColor.withAlpha(20),
          appBar: CustomAppBar(
            title: "key_product_management".tr(),
            showLeading: false,
            isShowCartIcon: false,
            isShowChatIcon: false,
          ),
          body: state.isLoading
              ? const CustomLoading(isLoading: true)
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'key_find_product'.tr(),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.search),
                        ),
                        onChanged: _filterSearch,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: PaginatedDataTable(
                          columnSpacing: 35,
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'key_table_product'.tr(),
                                style: AppTextStyles.textSize20(),
                              ),
                              SizedBox(
                                width: context.widthScreen * 0.5,
                              ),
                              Expanded(
                                child: CustomButton(
                                  text: "key_add_product".tr(),
                                  onPressed: () {
                                    NavigationService.instance
                                        .pushNamed("create_product");
                                  },
                                ),
                              )
                            ],
                          ),
                          rowsPerPage: 10,
                          sortColumnIndex: _dataSource.sortColumnIndex,
                          sortAscending: _dataSource.sortAscending,
                          columns: [
                            DataColumn(
                              label: Text(
                                'key_STT'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_name_product'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.productName ?? "",
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_price_VND'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_category'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_in_stock'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_solded'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_review'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_action'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                            ),
                          ],
                          source: _dataSource,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class ProductDataSource extends DataTableSource {
  List<SellerProduct> _products;
  int? sortColumnIndex;
  bool sortAscending = true;
  final ProductManagementBloc _bloc;
  ProductDataSource(this._products, this._bloc);

  void updateData(List<SellerProduct> newData) {
    _products = newData;
    notifyListeners();
  }

  void sort<T extends Comparable<dynamic>>({
    required T Function(SellerProduct p) getField,
    required bool ascending,
    required int columnIndex,
    required VoidCallback refresh,
  }) {
    _products.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    refresh();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _products.length) return null;
    final product = _products[index];
    int instock = 0;
    (product.variants ?? []).map((item) {
      instock = instock + (item.stock ?? 0);
    }).toList();
    return DataRow(cells: [
      DataCell(Text('${index + 1}', style: AppTextStyles.textSize16())),
      DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomCacheImageNetwork(
            imageUrl: product.cover,
            height: 40,
            width: 40,
            borderRadius: 20,
          ),
          20.w,
          Text(
            product.productName ?? "",
            style: AppTextStyles.textSize16(),
          ),
        ],
      )),
      DataCell(Text(Helper.formatCurrencyVND(product.price ?? 0),
          style: AppTextStyles.textSize16())),
      DataCell(
          Text(product.category.name ?? "", style: AppTextStyles.textSize16())),
      DataCell(Text(instock.toString(), style: AppTextStyles.textSize16())),
      DataCell(
          Text('${product.totalSold ?? 0}', style: AppTextStyles.textSize16())),
      DataCell(Row(
        children: [
          Text((product.avgRating ?? 0.0).toStringAsFixed(1),
              style: AppTextStyles.textSize16()),
          5.w,
          RatingStarsWidget(rating: product.avgRating ?? 0)
        ],
      )),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.read_more),
            tooltip: "key_restock_product".tr(),
            onPressed: () {
              _bloc.add(SellerGetProductDetail(productId: product.productId));
              NavigationService.instance.pushNamed("product_restock");
            },
          ),
          IconButton(
            icon: const Icon(Icons.visibility),
            tooltip: "key_detail".tr(),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.lock),
            tooltip: "key_block_product".tr(),
            onPressed: () {},
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _products.length;

  @override
  int get selectedRowCount => 0;
}
