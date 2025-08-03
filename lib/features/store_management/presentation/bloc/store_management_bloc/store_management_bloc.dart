import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/store_management/domain/entities/store_entity.dart';
import 'package:thuongmaidientu/features/store_management/domain/usecases/get_list_store_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'store_management_event.dart';
part 'store_management_state.dart';

class StoreManagementBloc
    extends Bloc<StoreManagementEvent, StoreManagementState> {
  final GetListStoreUseCase _getListStoreUseCase;

  StoreManagementBloc(
    this._getListStoreUseCase,
  ) : super(StoreManagementState.empty()) {
    on<GetListStore>(_getListProduct);
  }

  void _getListProduct(
      GetListStore event, Emitter<StoreManagementState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listStore = await _getListStoreUseCase.call();
      emit(state.copyWith(isLoading: false, listStore: listStore));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listStore: state.listStore
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      log(e.toString());
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
