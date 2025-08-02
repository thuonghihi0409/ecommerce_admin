import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/province_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/ward_entity.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getProfile(String email) async {
    final profile = await remoteDataSource.getProfile(email);
    return profile;
  }

  @override
  Future<List<AddressEntity>> getAddress(String id) async {
    final address = await remoteDataSource.getAddress(id);

    return address;
  }

  @override
  Future<List<ProvinceEntity>> getProvince() async {
    final address = await remoteDataSource.getProvince();

    return address;
  }

  @override
  Future<List<WardEntity>> getWard(String id) async {
    final address = await remoteDataSource.getWard(id);

    return address;
  }

  @override
  Future<AddressEntity> addAddress(
      AddressEntity addAddress, String userId) async {
    final address = await remoteDataSource.addAddress(addAddress, userId);
    return address;
  }

  @override
  Future<List<Store>> getStore(String userId) async {
    final store = await remoteDataSource.getStore(userId);
    return store;
  }

  @override
  Future<Store> createStore(Store store, String userId) async {
    final stores = await remoteDataSource.createStore(store, userId);
    return stores;
  }
}
