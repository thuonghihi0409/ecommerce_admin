import 'package:thuongmaidientu/features/dashboard/data/models/statistic_model.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/top_ordered_product_entity.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';

abstract class DashboardRemoteDatasource {
  Future<StatisticModel> getDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDatasource {
  DashboardRemoteDataSourceImpl();

  @override
  Future<StatisticModel> getDashboard() async {
    final totalProductsRes = await supabase.from('Products').select('id');
    final totalProduct = totalProductsRes.length;
    final topProducts = await supabase
        .from('Products')
        .select('*')
        .order('total_sold', ascending: false)
        .limit(10);
    final listPrduct = topProducts
        .map((item) => TopProductEntity(
            id: item["id"],
            totalOrdered: item["total_sold"],
            avgRating: item["avg_rating"],
            name: item["product_name"]))
        .toList();

    final topRatingProducts = await supabase
        .from('Products')
        .select('*')
        .order('avg_rating', ascending: false)
        .limit(10);
    final listRatingPrduct = topRatingProducts
        .map((item) => TopProductEntity(
            id: item["id"],
            totalOrdered: item["total_sold"],
            avgRating: item["avg_rating"],
            name: item["product_name"]))
        .toList();

    final totalOrdersRes = await supabase.from('Orders').select('id');
    final totalOrder = totalOrdersRes.length;

    final totalStoreRes = await supabase.from('Stores').select('id');
    final totalStores = totalStoreRes.length;

    final totalUserRes = await supabase.from('Users').select('id');
    final totalUsers = totalUserRes.length;
    return StatisticModel(
      topAvgRatingProducts: listRatingPrduct,
      totalOrders: totalOrder,
      totalProducts: totalProduct,
      topOrderedProducts: listPrduct,
      transactions: null,
      revenue: null,
      totalStores: totalStores,
      totalUsers: totalUsers,
    );
  }
}
