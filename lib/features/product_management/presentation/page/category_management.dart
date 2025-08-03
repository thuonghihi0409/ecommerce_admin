import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class CategoryManagementPage extends StatefulWidget {
  const CategoryManagementPage({super.key});

  @override
  State<CategoryManagementPage> createState() => _CategoryManagementPageState();
}

class _CategoryManagementPageState extends State<CategoryManagementPage> {
  final int _selectCategory = -1;
  late ProductDataSource _dataSource;
  List<Category> _products = [];

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
          .where((p) => (p.name ?? "").toLowerCase().contains(_searchQuery))
          .toList();
      _dataSource.updateData(filtered);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductManagementBloc, ProductManagementState>(
      builder: (context, state) {
        _products = state.listCategory ?? [];
        _dataSource = ProductDataSource(_products, _productManagementBloc);

        return Scaffold(
          backgroundColor: AppColor.greyColor.withAlpha(20),
          appBar: CustomAppBar(
            title: "key_category_management".tr(),
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
                                'key_table_category'.tr(),
                                style: AppTextStyles.textSize20(),
                              ),
                              SizedBox(
                                width: context.widthScreen * 0.5,
                              ),
                              Expanded(
                                child: CustomButton(
                                  text: "key_add_category".tr(),
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
                                'key_name_category'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.name ?? "",
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_total_product'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.total ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_description'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.description ?? "",
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
  List<Category> _products;
  int? sortColumnIndex;
  bool sortAscending = true;
  final ProductManagementBloc _bloc;
  ProductDataSource(this._products, this._bloc);

  void updateData(List<Category> newData) {
    _products = newData;
    notifyListeners();
  }

  void sort<T extends Comparable<dynamic>>({
    required T Function(Category p) getField,
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
            product.name ?? "",
            style: AppTextStyles.textSize16(),
          ),
        ],
      )),
      DataCell(
          Text(product.total.toString(), style: AppTextStyles.textSize16())),
      DataCell(
          Text(product.description ?? "", style: AppTextStyles.textSize16())),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.read_more),
            tooltip: "key_restock_product".tr(),
            onPressed: () {
              // _bloc.add(SellerGetProductDetail(productId: product.produ));
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
