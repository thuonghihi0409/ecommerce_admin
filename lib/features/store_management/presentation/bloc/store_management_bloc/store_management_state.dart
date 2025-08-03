part of 'store_management_bloc.dart';

class StoreManagementState extends Equatable {
  final ListModel<StoreEntity> listStore;
  final List<Category>? listCategory;
  final ProductDetail? productDetailModel;

  final List<Product>? productSummerice;
  final bool isGetDetail;
  final String getProductDetailError;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const StoreManagementState({
    required this.listStore,
    this.productDetailModel,
    this.listCategory,
    this.getProductDetailError = '',
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.productSummerice,
  });

  factory StoreManagementState.empty() {
    return const StoreManagementState(
        listStore: ListModel(),
        isGetDetail: false,
        getProductDetailError: "",
        productDetailModel: null,
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        productSummerice: null,
        listCategory: null);
  }

  StoreManagementState copyWith(
      {ListModel<StoreEntity>? listStore,
      ProductDetail? productDetailModel,
      bool? isGetDetail,
      String? getProductDetailError,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      List<Product>? listProductSummerice,
      Store? store,
      List<Category>? listCategory}) {
    return StoreManagementState(
        listStore: listStore ?? this.listStore,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        isGetDetail: isGetDetail ?? this.isGetDetail,
        productDetailModel: productDetailModel ?? this.productDetailModel,
        getProductDetailError:
            getProductDetailError ?? this.getProductDetailError,
        productSummerice: listProductSummerice ?? productSummerice,
        listCategory: listCategory ?? this.listCategory);
  }

  @override
  List<Object?> get props => [
        listStore,
        isLoading,
        isLoadingMore,
        isRefreshing,
        isGetDetail,
        productDetailModel,
        getProductDetailError,
        productSummerice,
        listCategory
      ];
}
