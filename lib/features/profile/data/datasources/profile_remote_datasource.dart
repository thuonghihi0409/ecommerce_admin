import 'package:thuongmaidientu/features/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/data/models/profile_model.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/province_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/ward_entity.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileEntityModel> getProfile(String email);
  Future<List<AddressEntity>> getAddress(String id);
  Future<List<ProvinceEntity>> getProvince();
  Future<List<WardEntity>> getWard(String id);
  Future<AddressEntity> addAddress(AddressEntity addAddress, String userId);
  Future<List<Store>> getStore(String userId);
  Future<Store> createStore(Store store, String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDatasource {
  @override
  Future<ProfileEntityModel> getProfile(String email) async {
    final profile =
        await supabase.from("Users").select().eq("email", email).single();

    return ProfileEntityModel.fromJson(profile);
  }

  @override
  Future<List<AddressEntity>> getAddress(String id) async {
    final address = await supabase.from('Address').select('''
      id, 
      name,
      phone,
      address,
      province:Provinces (code, name),
      ward:Wards (code, name)
    ''').eq('user_id', id);

    return address.map((e) => AddressEntity.fromJson(e)).toList();
  }

  @override
  Future<List<ProvinceEntity>> getProvince() async {
    final address = await supabase.from("Provinces").select();

    return address.map((e) => ProvinceEntity.fromJson(e)).toList();
  }

  @override
  Future<List<WardEntity>> getWard(String id) async {
    final address = await supabase.from("Wards").select().eq("parent_code", id);

    return address.map((e) => WardEntity.fromJson(e)).toList();
  }

  @override
  Future<AddressEntity> addAddress(
      AddressEntity addAddress, String userId) async {
    final result = await supabase
        .from("Address")
        .insert({
          "user_id": userId,
          "name": addAddress.name,
          "phone": addAddress.phone,
          "address": addAddress.address,
          "province": addAddress.province?.code,
          "ward": addAddress.ward?.code
        })
        .select()
        .single();
    final address = await supabase.from('Address').select('''
      id, 
      name,
      phone,
      address,
      province:Provinces (code, name),
      ward:Wards (code, name)
    ''').eq('id', result['id']).single();
    return AddressEntity.fromJson(address);
  }

  @override
  Future<List<Store>> getStore(String userId) async {
    final stores =
        await supabase.from('Stores').select('''*''').eq('user_id', userId);
    return stores.map((e) => StoreModel.fromJson(e)).toList();
  }

  @override
  Future<Store> createStore(Store store, String userId) async {
    final newStore = await supabase.from('Stores').insert({
      "user_id": userId,
      "name": store.name,
      "address": store.address,
      "phone": store.phone,
      "logo_url": store.logoUrl,
      "background_url": store.backgroundUrl,
      "total_product": store.totalProducts,
      "avg_rating": store.averageRating
    }).select('''*''').single();
    await supabase.from("Users").update({"role": "is_seller"}).eq("id", userId);
    return StoreModel.fromJson(newStore);
  }
}
