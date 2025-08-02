import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/statistic_entity.dart';
import 'package:thuongmaidientu/features/dashboard/domain/usecases/seller_get_dashboard_cart_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final SellerGetDashboardCartUsecase sellerGetDashboardCartUsecase;
  DashboardBloc(this.sellerGetDashboardCartUsecase)
      : super(DashboardState.empty()) {
    on<GetStatisticDay>(_getStatisticDay);
    on<GetStatisticMonth>(_getStatisticMonth);
    on<GetStatisticYear>(_getStatisticYear);
  }

  void _getStatisticDay(
      GetStatisticDay event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(isLoadingDay: true));

      StatisticEntity? newStatistic =
          await sellerGetDashboardCartUsecase.call();

      emit(state.copyWith(
          statisticDay: newStatistic,
          isLoadingDay: false,
          errorMessageDay: ""));
    } catch (e) {
      emit(state.copyWith(
          isLoadingDay: false,
          errorMessageDay: ParseError.fromJson(e).message));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  void _getStatisticMonth(
      GetStatisticMonth event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(isLoadingMonth: true));

      StatisticEntity? newStatistic =
          await sellerGetDashboardCartUsecase.call();

      emit(state.copyWith(
          statisticMonth: newStatistic,
          isLoadingMonth: false,
          errorMessageMonth: ""));
    } catch (e) {
      emit(state.copyWith(
          isLoadingMonth: false,
          errorMessageMonth: ParseError.fromJson(e).message));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  void _getStatisticYear(
      GetStatisticYear event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(isLoadingYear: true));

      StatisticEntity? newStatistic =
          await sellerGetDashboardCartUsecase.call();

      emit(state.copyWith(
          statisticYear: newStatistic,
          isLoadingYear: false,
          errorMessageYear: ""));
    } catch (e) {
      emit(state.copyWith(
          isLoadingYear: false,
          errorMessageYear: ParseError.fromJson(e).message));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }
}
