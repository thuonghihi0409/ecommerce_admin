import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/add_address.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/location_widget.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _confirmPasswordController;
  late FocusNode _usernameNode;

  late FocusNode _phoneNode;
  late FocusNode _confirmPasswordNode;

  bool _isValidName = false;
  late ProfileBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = context.read<ProfileBloc>();
    _usernameController = TextEditingController();
    _usernameController.text = _bloc.state.profile?.name ?? "";
    _emailController = TextEditingController();
    _emailController.text = _bloc.state.profile?.email ?? "";
    _phoneController = TextEditingController();
    _phoneController.text = _bloc.state.profile?.phone ?? "";
    _confirmPasswordController = TextEditingController();
    _usernameNode = FocusNode();

    _phoneNode = FocusNode();
    _confirmPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    _usernameNode.dispose();

    _phoneNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  void _submit() {}

  _enableButton() {
    return _isValidName;
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return CustomLoading(
          isOverlay: true,
          isLoading: state.isLoading,
        );
      }),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "key_update_persional_profile".tr(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.h,
                  CustomTextField(
                      hintText: "key_name".tr(),
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      labelText: "key_name".tr(),
                      controller: _usernameController,
                      focusNode: _usernameNode,
                      textInputAction: TextInputAction.next,
                      validType: ValidType.notEmpty,
                      isShowErrorMessage: true,
                      onFieldSubmitted: (p0) {
                        _phoneNode.requestFocus();
                      },
                      validator: (value) {
                        setState(() {
                          _isValidName = value ?? false;
                        });
                      }),
                  15.h,
                  CustomTextField(
                    readOnly: true,
                    validType: ValidType.email,
                    isShowErrorMessage: true,
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: "key_email".tr(),
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                  ),
                  15.h,
                  CustomTextField(
                    hintText: "key_phone".tr(),
                    prefixIcon: const Icon(Icons.phone),
                    isShowErrorMessage: true,
                    labelText: "key_phone".tr(),
                    controller: _phoneController,
                    focusNode: _phoneNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (p0) {
                      _confirmPasswordNode.requestFocus();
                    },
                  ),
                  20.h,
                  const Divider(),
                  Text(
                    "key_address".tr(),
                    style: AppTextStyles.textSize20(),
                  ),
                  10.h,
                  ...(state.address ?? [])
                      .map((address) => LocationWidget(address: address)),
                  20.h,
                  InkWell(
                    onTap: () {
                      NavigationService.instance.push(const AddAddressPage());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.add),
                        20.w,
                        Text(
                          "key_add_location".tr(),
                          style: AppTextStyles.textSize18(),
                        )
                      ],
                    ),
                  ),
                  50.h,
                  CustomButton(
                    isEnable: _enableButton(),
                    text: "key_update".tr(),
                    onPressed: () {
                      _submit();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
