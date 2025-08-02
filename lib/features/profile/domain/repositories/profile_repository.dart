import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/province_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/ward_entity.dart';

import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(String email);
  Future<List<AddressEntity>> getAddress(String id);
  Future<List<ProvinceEntity>> getProvince();
  Future<List<WardEntity>> getWard(String id);
  Future<AddressEntity> addAddress(AddressEntity addAddress, String userId);
  Future<List<Store>> getStore(String userId);
  Future<Store> createStore(Store store, String userId);
}
