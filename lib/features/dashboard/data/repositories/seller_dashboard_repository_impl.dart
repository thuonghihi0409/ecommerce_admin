import 'package:thuongmaidientu/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/statistic_entity.dart';
import 'package:thuongmaidientu/features/dashboard/domain/repositories/seller_dashboard_repository.dart';

class SellerDashboardRepositoryImpl implements SellerDashboardRepository {
  final DashboardRemoteDatasource remoteDataSource;

  SellerDashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<StatisticEntity> getDashboard() async {
    final count = await remoteDataSource.getDashboard();
    return count;
  }
}
