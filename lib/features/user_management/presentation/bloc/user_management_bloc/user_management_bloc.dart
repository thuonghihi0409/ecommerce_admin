import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/create_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_update_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_update_variant_usecase.dart';
import 'package:thuongmaidientu/features/user_management/domain/entities/user_entity.dart';
import 'package:thuongmaidientu/features/user_management/domain/usecases/get_list_user_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final GetListUserUseCase _getListUserUseCase;
  final SellerGetProductDetailUsecase _getProductDetailUsecase;
  final CreateProductUsecase _createProductUsecase;
  final SellerGetListCategoryUseCase _getListCategoryUseCase;
  final SellerUpdateProductUseCase _updateProductUsecase;
  final SellerUpdateVariantUseCase _updateVariantUsecase;
  UserManagementBloc(
      this._getListUserUseCase,
      this._getProductDetailUsecase,
      this._getListCategoryUseCase,
      this._createProductUsecase,
      this._updateProductUsecase,
      this._updateVariantUsecase)
      : super(UserManagementState.empty()) {
    on<GetListUser>(_getListProduct);
    on<SellerGetListCategory>(_getListCategory);
    on<SellerGetProductDetail>(_getProductDetail);
    on<SellerCreateProduct>(_createProduct);
    on<SellerUpdateProduct>(_updateProduct);
    on<SellerUpdateVariant>(_updateVariant);
  }

  void _getListProduct(
      GetListUser event, Emitter<UserManagementState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listProduct = await _getListUserUseCase.call();
      emit(state.copyWith(isLoading: false, listUser: listProduct));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listUser: state.listUser
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      log(e.toString());
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getListCategory(
      SellerGetListCategory event, Emitter<UserManagementState> emit) async {
    try {
      final listCategory = await _getListCategoryUseCase.call();

      emit(state.copyWith(listCategory: listCategory));
    } catch (e) {
      emit(state.copyWith(
          listUser: state.listUser
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getProductDetail(
      SellerGetProductDetail event, Emitter<UserManagementState> emit) async {
    try {
      emit(state.copyWith(isGetDetail: true));
      final product = await _getProductDetailUsecase.call(event.productId);

      emit(state.copyWith(
        isGetDetail: false,
        productDetailModel: product,
        getProductDetailError: "",
      ));
    } catch (e) {
      emit(state.copyWith(
          isGetDetail: false,
          getProductDetailError: ParseError.fromJson(e).message));
      log(ParseError.fromJson(e).message);
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _createProduct(
      SellerCreateProduct event, Emitter<UserManagementState> emit) async {
    try {
      emit(state.copyWith(isGetDetail: true));
      await _createProductUsecase.call(event.productDetail);
      event.onSuccess?.call();
      emit(state.copyWith(isGetDetail: false));
    } catch (e) {
      emit(state.copyWith(isGetDetail: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      event.onError?.call();
      log(ParseError.fromJson(e).message);
    }
  }

  void _updateProduct(
      SellerUpdateProduct event, Emitter<UserManagementState> emit) async {
    try {
      emit(state.copyWith(isGetDetail: true));
      await _updateProductUsecase.call(event.productDetail);
      event.onSuccess?.call();
      emit(state.copyWith(isGetDetail: false));
    } catch (e) {
      emit(state.copyWith(isGetDetail: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);

      log(ParseError.fromJson(e).message);
    }
  }

  void _updateVariant(
      SellerUpdateVariant event, Emitter<UserManagementState> emit) async {
    try {
      await _updateVariantUsecase.call(event.variants);
      event.onSuccess?.call();
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);

      log(ParseError.fromJson(e).message);
    }
  }
}
