part of 'product_bloc.dart';

class ProductState extends Equatable {
  final ListModel<Product> listProduct;
  final List<Category>? listCategory;
  final ProductDetail? productDetailModel;

  final List<Product>? productSummerice;
  final bool isGetDetail;
  final String getProductDetailError;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const ProductState({
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

  factory ProductState.empty() {
    return const ProductState(
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

  ProductState copyWith(
      {ListModel<Product>? listProduct,
      ProductDetail? productDetailModel,
      bool? isGetDetail,
      String? getProductDetailError,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      List<Product>? listProductSummerice,
      Store? store,
      List<Category>? listCategory}) {
    return ProductState(
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
