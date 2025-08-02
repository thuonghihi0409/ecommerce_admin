part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetStatisticDay extends DashboardEvent {
  const GetStatisticDay();
}

class GetStatisticMonth extends DashboardEvent {
  const GetStatisticMonth();
}

class GetStatisticYear extends DashboardEvent {
  const GetStatisticYear();
}
