import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_summerice_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetListProductUseCase _getListProductUseCase;
  final GetProductDetailUsecase _getProductDetailUsecase;

  final GetListProductSummericeUseCase _getListProductSummericeUseCase;
  final GetListCategoryUseCase _getListCategoryUseCase;
  ProductBloc(this._getListProductUseCase, this._getProductDetailUsecase,
      this._getListProductSummericeUseCase, this._getListCategoryUseCase)
      : super(ProductState.empty()) {
    on<GetListProduct>(_getListProduct);
    on<GetListCategory>(_getListCategory);
    on<GetProductDetail>(_getProductDetail);
  }

  void _getListProduct(GetListProduct event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(isLoading: event.isLoading));

      final listProduct = await _getListProductUseCase.call(
          search: event.search,
          categoryId: event.categoryId,
          maxPrice: event.maxPrice,
          minPrice: event.minPrice,
          storeId: event.storeId);
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
      GetListCategory event, Emitter<ProductState> emit) async {
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

  void _getProductDetail(
      GetProductDetail event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(isGetDetail: true));
      final product = await _getProductDetailUsecase.call(event.productId);

      final listSummerice =
          await _getListProductSummericeUseCase.call(event.categoryId);

      emit(state.copyWith(
          isGetDetail: false,
          productDetailModel: product,
          getProductDetailError: "",
          listProductSummerice: listSummerice));
    } catch (e) {
      emit(state.copyWith(
          isGetDetail: false,
          getProductDetailError: ParseError.fromJson(e).message));
      log(ParseError.fromJson(e).message);
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
