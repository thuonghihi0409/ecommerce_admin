import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/create_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_update_product_usecase.dart';
import 'package:thuongmaidientu/features/product_management/domain/usecases/seller_update_variant_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'product_management_event.dart';
part 'product_management_state.dart';

class ProductManagementBloc
    extends Bloc<ProductManagementEvent, ProductManagementState> {
  final SellerGetListProductUseCase _getListProductUseCase;
  final SellerGetProductDetailUsecase _getProductDetailUsecase;
  final CreateProductUsecase _createProductUsecase;
  final SellerGetListCategoryUseCase _getListCategoryUseCase;
  final SellerUpdateProductUseCase _updateProductUsecase;
  final SellerUpdateVariantUseCase _updateVariantUsecase;
  ProductManagementBloc(
      this._getListProductUseCase,
      this._getProductDetailUsecase,
      this._getListCategoryUseCase,
      this._createProductUsecase,
      this._updateProductUsecase,
      this._updateVariantUsecase)
      : super(ProductManagementState.empty()) {
    on<SellerGetListProduct>(_getListProduct);
    on<SellerGetListCategory>(_getListCategory);
    on<SellerGetProductDetail>(_getProductDetail);
    on<SellerCreateProduct>(_createProduct);
    on<SellerUpdateProduct>(_updateProduct);
    on<SellerUpdateVariant>(_updateVariant);
  }

  void _getListProduct(
      SellerGetListProduct event, Emitter<ProductManagementState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listProduct = await _getListProductUseCase.call(event.id);
      emit(state.copyWith(isLoading: false, listProduct: listProduct));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listProduct: state.listProduct
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      log(e.toString());
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getListCategory(
      SellerGetListCategory event, Emitter<ProductManagementState> emit) async {
    try {
      final listCategory = await _getListCategoryUseCase.call();

      emit(state.copyWith(listCategory: listCategory));
    } catch (e) {
      emit(state.copyWith(
          listProduct: state.listProduct
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getProductDetail(SellerGetProductDetail event,
      Emitter<ProductManagementState> emit) async {
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
      SellerCreateProduct event, Emitter<ProductManagementState> emit) async {
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
      SellerUpdateProduct event, Emitter<ProductManagementState> emit) async {
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
      SellerUpdateVariant event, Emitter<ProductManagementState> emit) async {
    try {
      await _updateVariantUsecase.call(event.variants);
      event.onSuccess?.call();
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);

      log(ParseError.fromJson(e).message);
    }
  }
}
