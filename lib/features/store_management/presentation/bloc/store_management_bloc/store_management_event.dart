part of 'store_management_bloc.dart';

class StoreManagementEvent extends Equatable {
  const StoreManagementEvent();

  @override
  List<Object> get props => [];
}

class GetListStore extends StoreManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListStore(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class SellerGetListCategory extends StoreManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const SellerGetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class SellerGetProductDetail extends StoreManagementEvent {
  final String productId;

  const SellerGetProductDetail({required this.productId});
}

class SellerCreateProduct extends StoreManagementEvent {
  final ProductDetail productDetail;
  final Function? onSuccess;
  final Function? onError;
  const SellerCreateProduct(
      {required this.productDetail, this.onSuccess, this.onError});
}

class SellerUpdateProduct extends StoreManagementEvent {
  final ProductDetail productDetail;
  final Function? onSuccess;
  const SellerUpdateProduct({required this.productDetail, this.onSuccess});
}

class SellerUpdateVariant extends StoreManagementEvent {
  final List<Variant> variants;
  final Function? onSuccess;
  const SellerUpdateVariant({required this.variants, this.onSuccess});
}
