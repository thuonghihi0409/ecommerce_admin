part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {
  final String email;
  final Function? onSuccess;
  final Function? onError;
  const GetProfile({required this.email, this.onSuccess, this.onError});
}

class GetAddress extends ProfileEvent {
  final String id;
  const GetAddress({required this.id});
}

class GetProvinces extends ProfileEvent {
  const GetProvinces();
}

class GetWards extends ProfileEvent {
  final String id;
  const GetWards({required this.id});
}

class SetStore extends ProfileEvent {
  final Store store;
  const SetStore({required this.store});
}

class AddAddress extends ProfileEvent {
  final String id;
  final AddressEntity addressEntity;
  final Function? onSuccess;
  const AddAddress(
      {required this.id, required this.addressEntity, this.onSuccess});
}

class UpdateProfile extends ProfileEvent {
  final ProfileEntity profile;
  final Function? onSuccess;
  final Function? onError;
  const UpdateProfile({required this.profile, this.onSuccess, this.onError});
}

class CreateStore extends ProfileEvent {
  final Store store;
  final Function? onSuccess;
  const CreateStore({required this.store, this.onSuccess});
}
