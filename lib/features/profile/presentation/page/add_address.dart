import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/province_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/ward_entity.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class AddAddressPage extends StatefulWidget {
  final Function? onSuccess;
  const AddAddressPage({super.key, this.onSuccess});

  @override
  State<AddAddressPage> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressPage> {
  final GlobalKey<DropdownSearchState<String>> provinceDropdownKey =
      GlobalKey();
  final GlobalKey<DropdownSearchState<String>> wardDropdownKey = GlobalKey();
  late ProfileBloc _bloc;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final nameNode = FocusNode();
  final phoneNode = FocusNode();
  final addressNode = FocusNode();

  late ProvinceEntity? provinceEntity;
  late WardEntity? wardEntity;

  bool _isValidName = false, _isValidPhone = false, _isValidAddress = false;

  _enableButton() =>
      _isValidAddress &&
      _isValidName &&
      _isValidPhone &&
      provinceEntity != null &&
      wardEntity != null;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ProfileBloc>();
    _getData();
  }

  _getData() async {
    _bloc.add(const GetProvinces());
  }

  _submit() async {
    _bloc.add(AddAddress(
        onSuccess: () {
          NavigationService.instance.goBack();
          widget.onSuccess?.call();
        },
        id: _bloc.state.profile?.id ?? "",
        addressEntity: AddressEntity(
            province: provinceEntity,
            ward: wardEntity,
            address: addressController.text,
            phone: int.tryParse(phoneController.text) ?? 000000,
            name: nameController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Scaffold(
          appBar: CustomAppBar(
            title: "key_add_address".tr(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.h,
                  CustomTextField(
                    validType: ValidType.notEmpty,
                    validator: (val) {
                      setState(() {
                        _isValidName = val ?? false;
                      });
                    },
                    controller: nameController,
                    focusNode: nameNode,
                    labelText: "key_name".tr(),
                  ),
                  20.h,
                  CustomTextField(
                    keyboardType: TextInputType.phone,
                    validType: ValidType.notEmpty,
                    validator: (val) {
                      setState(() {
                        _isValidPhone = val ?? false;
                      });
                    },
                    focusNode: phoneNode,
                    controller: phoneController,
                    labelText: "key_phone_number".tr(),
                  ),
                  20.h,
                  Text(
                    "key_province".tr(),
                    style: AppTextStyles.textSize16(),
                  ),
                  5.h,
                  DropdownSearch<ProvinceEntity>(
                    key: provinceDropdownKey,
                    dropdownBuilder: (context, province) =>
                        Text(province?.name ?? ""),
                    itemAsString: (item) => item.name,
                    compareFn: (ProvinceEntity a, ProvinceEntity b) =>
                        a.code == b.code,
                    items: (String filter, LoadProps? props) async {
                      return (state.provinces ??
                              [
                               
                              ])
                          .where((item) => item.name.contains(filter))
                          .toList();
                    },
                    popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                                focusColor: AppColor.greyColor,
                                contentPadding: EdgeInsets.all(8)))),
                    decoratorProps: const DropDownDecoratorProps(
                      decoration: InputDecoration(
                        hint: Text("Chon tinh"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    onChanged: (value) {
                      _bloc.add(GetWards(id: value?.code ?? ""));
                      provinceEntity = value;
                    },
                  ),
                  20.h,
                  Text(
                    "key_ward".tr(),
                    style: AppTextStyles.textSize16(),
                  ),
                  5.h,
                  DropdownSearch<WardEntity>(
                    compareFn: (item1, item2) => item1.code == item2.code,
                    itemAsString: (item) => item.name,
                    dropdownBuilder: (context, selectedItem) =>
                        Text(selectedItem?.name ?? ""),
                    key: wardDropdownKey,
                    items: (String filter, LoadProps? props) async {
                      return (state.wards ?? [])
                          .where((item) => item.name.contains(filter))
                          .toList();
                    },
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    decoratorProps: const DropDownDecoratorProps(
                      decoration: InputDecoration(
                        hint: Text("Chon xa"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    onChanged: (val) {
                      wardEntity = val;
                    },
                  ),
                  20.h,
                  CustomTextField(
                    validType: ValidType.notEmpty,
                    validator: (val) {
                      setState(() {
                        _isValidAddress = val ?? false;
                      });
                    },
                    labelText: "key_address".tr(),
                    controller: addressController,
                    focusNode: addressNode,
                  ),
                  20.h,
                  if (_enableButton())
                    Text(
                        "${addressController.text},${wardEntity?.name ?? ""}, ${provinceEntity?.name ?? ""}"),
                  if (_enableButton()) 20.h,
                  CustomButton(
                    isEnable: _enableButton(),
                    text: "key_add".tr(),
                    onPressed: _submit,
                  )
                ],
              ),
            ),
          ));
    });
  }
}
