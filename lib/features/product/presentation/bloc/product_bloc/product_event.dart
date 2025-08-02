part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetListProduct extends ProductEvent {
  final String? search;
  final String? categoryId;
  final int? minPrice;
  final int? maxPrice;
  final String? storeId;
  final bool isLoadingMore, isRefreshing, isLoading;
  const GetListProduct({
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.isLoading = true,
    this.search,
    this.categoryId,
    this.minPrice,
    this.maxPrice,
    this.storeId,
  });
}

class GetListCategory extends ProductEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetProductDetail extends ProductEvent {
  final String productId;
  final String categoryId;
  const GetProductDetail({required this.productId, required this.categoryId});
}
