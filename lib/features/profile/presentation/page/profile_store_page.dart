import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/firebase_service.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/upload_image_widget.dart';
import 'package:thuongmaidientu/web_main_drawer.dart';

class ProfileStorePage extends StatefulWidget {
  const ProfileStorePage({super.key});

  @override
  State<ProfileStorePage> createState() => _ProfileStorePageState();
}

class _ProfileStorePageState extends State<ProfileStorePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  late ProfileBloc _bloc;

  Uint8List? _logoImage;
  Uint8List? _backgroundImage;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ProfileBloc>();
  }

  void _submitStore() async {
    if (_formKey.currentState!.validate()) {
      if (_logoImage == null || _backgroundImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vui lòng chọn logo và ảnh nền")),
        );
        return;
      }
      try {
        final logo =
            await FirebaseService.instance.uploadImagesData(_logoImage!);
        final background =
            await FirebaseService.instance.uploadImagesData(_backgroundImage!);
        final store = Store(
            phone: _phoneController.text,
            id: "",
            name: _nameController.text,
            logoUrl: logo,
            address: _addressController.text,
            averageRating: null,
            totalProducts: 0,
            backgroundUrl: background);

        _bloc.add(
          CreateStore(
              store: store,
              onSuccess: () {
                Helper.showToastBottom(
                    message: "key_create_store_success".tr());
                NavigationService.instance
                    .popUntilRootAndReplace(const WebMainDrawer());
              }),
        );
      } catch (e) {
        Helper.showToastBottom(message: ParseError.fromJson(e).message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "key_create_store".tr(),
        showLeading: false,
      ),
      body: Padding(
        padding: kIsWeb
            ? EdgeInsetsGeometry.symmetric(
                vertical: 12, horizontal: context.widthScreen * 0.2)
            : const EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "key_upload_logo_store".tr(),
                      style: AppTextStyles.textSize16(),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: MultiImagePickerWidget(
                        allowMultiple: false,
                        onSuccess: (images) {
                          if (images.isNotEmpty) _logoImage = images[0];
                        },
                      ))
                ],
              ),
              20.h,
              // Background
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "key_upload_background_store".tr(),
                      style: AppTextStyles.textSize16(),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: MultiImagePickerWidget(
                        allowMultiple: false,
                        onSuccess: (images) {
                          if (images.isNotEmpty) _backgroundImage = images[0];
                        },
                      ))
                ],
              ),
              20.h,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "key_name_store".tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập tên cửa hàng" : null,
              ),
              20.h,
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: "key_address".tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập địa chỉ" : null,
              ),
              30.h,
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "key_phone_number".tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập số điện thoại" : null,
              ),
              30.h,
              CustomButton(
                text: "key_create_store".tr(),
                onPressed: _submitStore,
              )
            ],
          ),
        ),
      ),
    );
  }
}
