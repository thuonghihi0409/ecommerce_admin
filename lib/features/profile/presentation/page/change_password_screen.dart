import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late FocusNode _oldPasswordNode;
  late FocusNode _passwordNode;
  late FocusNode _confirmPasswordNode;

  bool _isValidEmail = false, _isValidPassword = false, _isValidName = false;

  @override
  void initState() {
    super.initState();

    _oldPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _oldPasswordNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _oldPasswordNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  void _submit() {}

  _enableButton() {
    return _isValidEmail &&
        _isValidPassword &&
        _isValidName &&
        (_passwordController.text == _confirmPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return CustomLoading(
          isLoading: state.isLoading,
          isOverlay: true,
        );
      }),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "key_change_password".tr(),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.h,
                SvgPicture.asset(
                  AppAssets.addUserIcon,
                  height: 80,
                  width: 80,
                ),
                15.h,
                CustomTextField(
                    hintText: "key_old_password".tr(),
                    validType: ValidType.password,
                    isPassword: true,
                    isShowErrorMessage: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    labelText: "key_old_password".tr(),
                    controller: _oldPasswordController,
                    focusNode: _oldPasswordNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (p0) {
                      _passwordNode.requestFocus();
                    },
                    validator: (value) {
                      setState(() {
                        _isValidEmail = value ?? false;
                      });
                    }),
                15.h,
                CustomTextField(
                  hintText: "key_password".tr(),
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validType: ValidType.password,
                  isShowErrorMessage: true,
                  labelText: "key_password".tr(),
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (p0) {
                    _confirmPasswordNode.requestFocus();
                  },
                  validator: (value) {
                    setState(() {
                      _isValidPassword = value ?? false;
                    });
                  },
                ),
                15.h,
                CustomTextField(
                  hintText: "key_password".tr(),
                  validType: ValidType.notEmpty,
                  isShowErrorMessage: _passwordController.text !=
                      _confirmPasswordController.text,
                  errorMessage: "Mật khẩu không khớp",
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  labelText: "key_confirm_password".tr(),
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (p0) {
                    _submit();
                  },
                  validator: (value) {
                    setState(() {});
                    return;
                  },
                ),
                50.h,
                CustomButton(
                  isEnable: _enableButton(),
                  text: "key_change_password".tr(),
                  onPressed: () {
                    _submit();
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
