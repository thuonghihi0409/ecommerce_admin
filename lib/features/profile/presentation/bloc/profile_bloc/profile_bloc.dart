import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/province_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/ward_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/add_address_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/create_store_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_address_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_list_store_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_provinces_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_wards_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfileUsecase getProfileUsecase;
  GetAddressUsecase getAddressUsecase;
  GetProvincesUsecase getProvincesUsecase;
  GetWardsUsecase getWardsUsecase;
  AddAddressUsecase addAddressUsecase;
  GetListStoreUsecase getListStoreUsecase;
  CreateStoreUsecase createStoreUsecase;
  ProfileBloc(
      this.getProfileUsecase,
      this.getAddressUsecase,
      this.getProvincesUsecase,
      this.getWardsUsecase,
      this.addAddressUsecase,
      this.getListStoreUsecase,
      this.createStoreUsecase)
      : super(ProfileState.empty()) {
    on<GetProfile>(getProfile);
    on<GetAddress>(getAddress);
    on<GetProvinces>(getProvinces);
    on<GetWards>(getWards);
    on<AddAddress>(addAddress);
    on<SetStore>(setStore);
    on<CreateStore>(createStore);
  }

  void getProfile(GetProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final profile = await getProfileUsecase.call(email: event.email);

      if (profile.role == "is_admin") {
        emit(state.copyWith(
          isLoading: false,
          profile: profile,
        ));
        event.onSuccess?.call();
      } else {
        Helper.showToastBottom(
            message: "key_you_have_note_admin_permission".tr());
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      event.onError?.call();
      emit(state.copyWith(isLoading: false));
      log(ParseError.fromJson(e).message);
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void getAddress(GetAddress event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final address = await getAddressUsecase.call(id: event.id);
      emit(state.copyWith(isLoading: false, address: address));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      log("error ====${ParseError.fromJson(e).message}");
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void addAddress(AddAddress event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final address = await addAddressUsecase.call(
          addAddress: event.addressEntity, id: event.id);
      final list = List<AddressEntity>.from(state.address ?? []);
      list.add(address);
      emit(state.copyWith(isLoading: false, address: list));
      event.onSuccess?.call();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      log("error ====${ParseError.fromJson(e).message}");
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void getProvinces(GetProvinces event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final provinces = await getProvincesUsecase.call();

      emit(state.copyWith(isLoading: false, provinces: provinces));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      log("error ====${ParseError.fromJson(e).message}");
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void getWards(GetWards event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final wards = await getWardsUsecase.call(id: event.id);
      emit(state.copyWith(isLoading: false, wards: wards));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      log("error ====${ParseError.fromJson(e).message}");
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void setStore(SetStore event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(store: event.store));
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void createStore(CreateStore event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final store = await createStoreUsecase.call(
          store: event.store, userId: state.profile?.id ?? "");
      emit(state.copyWith(store: store, isLoading: false));
      event.onSuccess?.call();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
