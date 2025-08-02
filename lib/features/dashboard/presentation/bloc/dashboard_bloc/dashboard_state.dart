part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoadingDay, isLoadingMonth, isLoadingYear;

  final StatisticEntity? statisticDay, statisticMonth, statisticYear;
  final String errorMessageDay, errorMessageMonth, errorMessageYear;

  const DashboardState({
    this.isLoadingDay = false,
    this.isLoadingMonth = false,
    this.isLoadingYear = false,
    this.statisticDay,
    this.statisticMonth,
    this.statisticYear,
    this.errorMessageDay = "",
    this.errorMessageMonth = "",
    this.errorMessageYear = "",
  });

  factory DashboardState.empty() {
    return const DashboardState(
        isLoadingDay: false,
        isLoadingMonth: false,
        isLoadingYear: false,
        statisticDay: null,
        statisticMonth: null,
        statisticYear: null,
        errorMessageDay: "",
        errorMessageMonth: "",
        errorMessageYear: "");
  }

  DashboardState copyWith(
      {bool? isLoadingDay,
      bool? isLoadingMonth,
      bool? isLoadingYear,
      StatisticEntity? statisticDay,
      StatisticEntity? statisticMonth,
      StatisticEntity? statisticYear,
      String? errorMessageDay,
      String? errorMessageMonth,
      String? errorMessageYear}) {
    return DashboardState(
        isLoadingDay: isLoadingDay ?? this.isLoadingDay,
        isLoadingMonth: isLoadingMonth ?? this.isLoadingMonth,
        isLoadingYear: isLoadingYear ?? this.isLoadingYear,
        statisticDay: statisticDay ?? this.statisticDay,
        statisticMonth: statisticMonth ?? this.statisticMonth,
        statisticYear: statisticYear ?? this.statisticYear,
        errorMessageDay: errorMessageDay ?? this.errorMessageDay,
        errorMessageMonth: errorMessageMonth ?? this.errorMessageMonth,
        errorMessageYear: errorMessageYear ?? this.errorMessageYear);
  }

  @override
  List<Object?> get props => [
        isLoadingDay,
        isLoadingMonth,
        isLoadingYear,
        statisticDay,
        statisticMonth,
        statisticYear,
        errorMessageDay,
        errorMessageMonth,
        errorMessageYear
      ];
}
