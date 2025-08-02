import 'package:thuongmaidientu/features/product/data/models/category_model.dart';
import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<ListModel<ProductModel>> getListProduct({
    String? search,
    String? categoryId,
    int? minPrice,
    int? maxPrice,
    String? storeId,
  });
  Future<ProductDetailModel> getProductDetail(String id);
  Future<Store> getStore();
  Future<List<ProductModel>> getListProductSummerice(String categoryId);
  Future<List<Category>> getListCategory();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDatasource {
  ProductRemoteDataSourceImpl();

  @override
  Future<ListModel<ProductModel>> getListProduct({
    String? search,
    String? categoryId,
    int? minPrice,
    int? maxPrice,
    String? storeId,
  }) async {
    var query = supabase.from("Products").select('''*, store: Stores(*)''');

    if (search != null && search.isNotEmpty) {
      query = query.ilike('product_name', '%$search%');
    }

    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }

    if (storeId != null) {
      query = query.eq('store_id', storeId);
    }

    if (minPrice != null) {
      query = query.gte('price', minPrice);
    }

    if (maxPrice != null) {
      query = query.lte('price', maxPrice);
    }

    final data = await query;

    final result = ListModel(
      results: data.map((e) => ProductModel.fromJson(e)).toList(),
    );

    return result;
  }

  @override
  Future<ProductDetailModel> getProductDetail(String id) async {
    final data = await supabase.from("Products").select('''
      *,
      images : Images(*),
      variants : Variants(*),
      store : Stores(*)
      ''').eq("id", id).single();

    return ProductDetailModel.fromJson(data);
  }

  @override
  Future<Store> getStore() async {
    final data = await supabase.from("Stores").select('''*''').single();

    return StoreModel.fromJson(data);
  }

  @override
  Future<List<ProductModel>> getListProductSummerice(String categoryId) async {
    final data = await supabase
        .from("Products")
        .select('''*,store : Stores(*)''').eq("category_id", categoryId);

    return data.map((product) => ProductModel.fromJson(product)).toList();
  }

  @override
  Future<List<CategoryModel>> getListCategory() async {
    final data = await supabase.from("Categories").select('''*''');

    return data.map((item) => CategoryModel.fromJson(item)).toList();
  }
}
