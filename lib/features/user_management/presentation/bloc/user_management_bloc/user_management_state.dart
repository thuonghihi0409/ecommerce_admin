part of 'user_management_bloc.dart';

class UserManagementState extends Equatable {
  final ListModel<UserEntity> listUser;
  final List<Category>? listCategory;
  final ProductDetail? productDetailModel;

  final List<Product>? productSummerice;
  final bool isGetDetail;
  final String getProductDetailError;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const UserManagementState({
    required this.listUser,
    this.productDetailModel,
    this.listCategory,
    this.getProductDetailError = '',
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.productSummerice,
  });

  factory UserManagementState.empty() {
    return const UserManagementState(
        listUser: ListModel(),
        isGetDetail: false,
        getProductDetailError: "",
        productDetailModel: null,
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        productSummerice: null,
        listCategory: null);
  }

  UserManagementState copyWith(
      {ListModel<UserEntity>? listUser,
      ProductDetail? productDetailModel,
      bool? isGetDetail,
      String? getProductDetailError,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      List<Product>? listProductSummerice,
      Store? store,
      List<Category>? listCategory}) {
    return UserManagementState(
        listUser: listUser ?? this.listUser,
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
        listUser,
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
