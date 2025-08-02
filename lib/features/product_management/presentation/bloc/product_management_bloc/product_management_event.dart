part of 'product_management_bloc.dart';

class ProductManagementEvent extends Equatable {
  const ProductManagementEvent();

  @override
  List<Object> get props => [];
}

class SellerGetListProduct extends ProductManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const SellerGetListProduct(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class SellerGetListCategory extends ProductManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const SellerGetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class SellerGetProductDetail extends ProductManagementEvent {
  final String productId;

  const SellerGetProductDetail({required this.productId});
}

class SellerCreateProduct extends ProductManagementEvent {
  final ProductDetail productDetail;
  final Function? onSuccess;
  final Function? onError;
  const SellerCreateProduct(
      {required this.productDetail, this.onSuccess, this.onError});
}

class SellerUpdateProduct extends ProductManagementEvent {
  final ProductDetail productDetail;
  final Function? onSuccess;
  const SellerUpdateProduct({required this.productDetail, this.onSuccess});
}

class SellerUpdateVariant extends ProductManagementEvent {
  final List<Variant> variants;
  final Function? onSuccess;
  const SellerUpdateVariant({required this.variants, this.onSuccess});
}
