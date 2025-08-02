import 'package:thuongmaidientu/features/product/data/models/category_model.dart';
import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product_management/data/models/seller_product_model.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ProductManagementRemoteDatasource {
  Future<ListModel<SellerProductModel>> getListProduct(String? storeId);
  Future<ProductDetailModel> getProductDetail(String id);
  Future<void> createProductDetail(ProductDetail product);
  Future<List<Category>> getListCategory();
  Future<void> updateVariants(List<Variant> variants);
  Future<void> updateProduct(ProductDetail product);
}

class ProductManagementRemoteDataSourceImpl
    implements ProductManagementRemoteDatasource {
  ProductManagementRemoteDataSourceImpl();

  @override
  Future<ListModel<SellerProductModel>> getListProduct(String? storeId) async {
    var query = supabase.from("Products").select('''
      *,
      variants : Variants(*),
      category: Categories(*)
      ''');
    if (storeId != null) {
      query = query.eq("store_id", storeId);
    }
    final data = await query;
    final result = ListModel(
        results: data
            .map((product) => SellerProductModel.fromJson(product))
            .toList());

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
  Future<List<CategoryModel>> getListCategory() async {
    final data = await supabase.from("Categories").select('''*''');

    return data.map((item) => CategoryModel.fromJson(item)).toList();
  }

  @override
  Future<void> createProductDetail(ProductDetail product) async {
    // 1. Insert vào bảng products
    final insertedProduct = await supabase
        .from('Products')
        .insert({
          'cover': product.cover,
          'product_name': product.productName,
          'description': product.description,
          'price': product.price,
          'category_id': product.categoryId,
          'store_id': product.store?.id,
          'avg_rating': product.avgRating,
          'total_sold': product.totalSold,
          'total_rating': product.totalRating,
        })
        .select()
        .single();

    final productId = insertedProduct['id'];

    // 2. Insert ảnh vào bảng product_images
    if (product.images != null && product.images!.isNotEmpty) {
      final imageData = product.images!.map((img) {
        return {
          'product_id': productId,
          'url': img.url,
          'alt': img.alt,
        };
      }).toList();

      await supabase.from('Images').insert(imageData);
    }

    // 3. Insert biến thể vào bảng product_variants
    if (product.variants != null && product.variants!.isNotEmpty) {
      final variantData = product.variants!.map((v) {
        return {
          'product_id': productId,
          'name': v.name,
          'price': v.price,
          'stock': v.stock,
          'cover': v.cover,
        };
      }).toList();

      await supabase.from('Variants').insert(variantData);
    }
  }

  @override
  Future<void> updateProduct(ProductDetail product) async {}

  @override
  Future<void> updateVariants(List<Variant> variants) async {
    for (final variant in variants) {
      await supabase.from('Variants').update({
        'stock': variant.stock,
      }).eq('id', variant.id);
    }
  }
}
