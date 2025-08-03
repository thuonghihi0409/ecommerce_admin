import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/user_management/domain/entities/user_entity.dart';
import 'package:thuongmaidientu/features/user_management/presentation/bloc/user_management_bloc/user_management_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final int _selectCategory = -1;
  late ProductDataSource _dataSource;
  List<UserEntity> _products = [];

  String _searchQuery = '';
  late UserManagementBloc _userManagementBloc;
  @override
  void initState() {
    super.initState();
    _userManagementBloc = context.read<UserManagementBloc>();
    _getDate();
  }

  _getDate() async {
    _userManagementBloc.add(const GetListUser());
  }

  void _filterSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      final filtered = _products
          .where((p) => (p.name).toLowerCase().contains(_searchQuery))
          .toList();
      _dataSource.updateData(filtered);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementBloc, UserManagementState>(
      builder: (context, state) {
        _products = state.listUser.results ?? [];
        _dataSource = ProductDataSource(_products, _userManagementBloc);

        return Scaffold(
          backgroundColor: AppColor.greyColor.withAlpha(20),
          appBar: CustomAppBar(
            title: "key_user_management".tr(),
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
                                'key_username'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.name,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_email'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.email ?? "",
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_phone'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.phone ?? "",
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_status'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.status ?? "",
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'key_role'.tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.role ?? "",
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
  List<UserEntity> _products;
  int? sortColumnIndex;
  bool sortAscending = true;
  final UserManagementBloc _bloc;
  ProductDataSource(this._products, this._bloc);

  void updateData(List<UserEntity> newData) {
    _products = newData;
    notifyListeners();
  }

  void sort<T extends Comparable<dynamic>>({
    required T Function(UserEntity p) getField,
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
            imageUrl: product.image,
            height: 40,
            width: 40,
            borderRadius: 20,
          ),
          20.w,
          Text(
            product.name,
            style: AppTextStyles.textSize16(),
          ),
        ],
      )),
      DataCell(Text(product.email ?? "", style: AppTextStyles.textSize16())),
      DataCell(
          Text('${product.phone ?? 0}', style: AppTextStyles.textSize16())),
      DataCell(Text(product.status ?? "", style: AppTextStyles.textSize16())),
      DataCell(Text(product.role ?? "", style: AppTextStyles.textSize16())),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.read_more),
            tooltip: "key_restock_product".tr(),
            onPressed: () {
              //  _bloc.add(SellerGetProductDetail(productId: product.id));
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
