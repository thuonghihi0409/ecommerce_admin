part of 'user_management_bloc.dart';

class UserManagementEvent extends Equatable {
  const UserManagementEvent();

  @override
  List<Object> get props => [];
}

class GetListUser extends UserManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListUser(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class SellerGetListCategory extends UserManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const SellerGetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class SellerGetProductDetail extends UserManagementEvent {
  final String productId;

  const SellerGetProductDetail({required this.productId});
}

class SellerCreateProduct extends UserManagementEvent {
  final ProductDetail productDetail;
  final Function? onSuccess;
  final Function? onError;
  const SellerCreateProduct(
      {required this.productDetail, this.onSuccess, this.onError});
}

class SellerUpdateProduct extends UserManagementEvent {
  final ProductDetail productDetail;
  final Function? onSuccess;
  const SellerUpdateProduct({required this.productDetail, this.onSuccess});
}

class SellerUpdateVariant extends UserManagementEvent {
  final List<Variant> variants;
  final Function? onSuccess;
  const SellerUpdateVariant({required this.variants, this.onSuccess});
}
