import 'package:thuongmaidientu/features/dashboard/domain/entities/statistic_entity.dart';

abstract class SellerDashboardRepository {
  Future<StatisticEntity> getDashboard();
}
