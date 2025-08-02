part of 'product_management_bloc.dart';

class ProductManagementState extends Equatable {
  final ListModel<SellerProduct> listProduct;
  final List<Category>? listCategory;
  final ProductDetail? productDetailModel;

  final List<Product>? productSummerice;
  final bool isGetDetail;
  final String getProductDetailError;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const ProductManagementState({
    required this.listProduct,
    this.productDetailModel,
    this.listCategory,
    this.getProductDetailError = '',
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.productSummerice,
  });

  factory ProductManagementState.empty() {
    return const ProductManagementState(
        listProduct: ListModel(),
        isGetDetail: false,
        getProductDetailError: "",
        productDetailModel: null,
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        productSummerice: null,
        listCategory: null);
  }

  ProductManagementState copyWith(
      {ListModel<SellerProduct>? listProduct,
      ProductDetail? productDetailModel,
      bool? isGetDetail,
      String? getProductDetailError,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      List<Product>? listProductSummerice,
      Store? store,
      List<Category>? listCategory}) {
    return ProductManagementState(
        listProduct: listProduct ?? this.listProduct,
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
        listProduct,
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
