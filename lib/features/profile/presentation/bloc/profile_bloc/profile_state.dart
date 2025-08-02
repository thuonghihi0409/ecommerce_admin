part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final ProfileEntity? profile;
  final Store? store;
  final List<Store>? listStores;
  final List<AddressEntity>? address;
  final List<ProvinceEntity>? provinces;
  final List<WardEntity>? wards;
  const ProfileState(
      {this.isLoading = false,
      this.profile,
      this.address,
      this.provinces,
      this.wards,
      this.store,
      this.listStores});
  factory ProfileState.empty() {
    return const ProfileState(
      isLoading: false,
      profile: null,
      store: null,
      address: null,
      provinces: null,
      wards: null,
      listStores: null,
    );
  }

  ProfileState copyWith(
      {bool? isLoading,
      ProfileEntity? profile,
      List<AddressEntity>? address,
      List<ProvinceEntity>? provinces,
      List<WardEntity>? wards,
      Store? store,
      List<Store>? listStores}) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        profile: profile ?? this.profile,
        provinces: provinces ?? this.provinces,
        address: address ?? this.address,
        wards: wards ?? this.wards,
        store: store ?? this.store,
        listStores: listStores ?? this.listStores);
  }

  @override
  List<Object?> get props =>
      [isLoading, profile, address, provinces, wards, store, listStores];
}
