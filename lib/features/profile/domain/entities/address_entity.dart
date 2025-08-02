import 'package:thuongmaidientu/features/profile/domain/entities/province_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/ward_entity.dart';

class AddressEntity {
  final String? id;
  final ProvinceEntity? province;
  final WardEntity? ward;
  final String address;
  final int? phone;
  final String? name;

  AddressEntity(
      {this.id,
      required this.province,
      required this.ward,
      required this.address,
      required this.phone,
      required this.name});

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
      name: json["name"],
      phone: json["phone"],
      id: json['id'],
      province: ProvinceEntity.fromJson(json),
      ward: WardEntity.fromJson(json),
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'phone': phone,
      'name': name,
      'province': province?.code,
      'ward': ward?.code,
      'address': address,
    };
  }
}
