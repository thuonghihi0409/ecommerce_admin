import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_constraint.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/forgot_password.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/verify_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';
import 'package:thuongmaidientu/web_main_drawer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late FocusNode _usernameFocus;
  late FocusNode _passwordFocus;
  bool _isValidEmail = false, _isValidPassword = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    context.read<AuthBloc>().add(AuthLogin(
        email: _usernameController.text,
        password: _passwordController.text,
        onSuccess: (val) {
          switch (val) {
            case AppConstraint.login:
              context.read<ProfileBloc>().add(GetProfile(
                  email: _usernameController.text,
                  onSuccess: () async {
                    NavigationService.instance
                        .popUntilRootAndReplace(const WebMainDrawer());
                  }));
              break;
            case AppConstraint.isNotVerify:
              Helper.showToastBottom(message: "Tài khoản chưa xác thực");
              NavigationService.instance
                  .push(VerifyPage(email: _usernameController.text));
              break;
            case AppConstraint.loginFailed:
              Helper.showToastBottom(message: "Tài khoản không tồn tại");
          }
        },
        onError: (val) {
          Helper.showToastBottom(message: val.toString());
        }));
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
          showLeading: false,
          title: "key_login".tr(),
          isShowCartIcon: false,
          isShowChatIcon: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: SingleChildScrollView(
            padding: kIsWeb
                ? EdgeInsets.symmetric(
                    horizontal: context.widthScreen > 1000
                        ? context.widthScreen * 0.2
                        : context.widthScreen * 0.1)
                : EdgeInsets.zero,
            child: Column(
              children: [
                30.h,
                SvgPicture.asset(
                  AppAssets.loginIcon,
                  height: 80,
                  width: 80,
                  colorFilter:
                      const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
                ),
                30.h,
                CustomTextField(
                  hintText: "key_email".tr(),
                  validType: ValidType.email,
                  isShowErrorMessage: true,
                  controller: _usernameController,
                  labelText: "key_email".tr(),
                  prefixIcon: const Icon(Icons.email_outlined),
                  focusNode: _usernameFocus,
                  validator: (val) {
                    setState(() {
                      _isValidEmail = val ?? false;
                    });
                    return;
                  },
                  onFieldSubmitted: (p0) {
                    _passwordFocus.requestFocus();
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  hintText: "key_password".tr(),
                  validator: (val) {
                    setState(() {
                      _isValidPassword = val ?? false;
                    });
                    return;
                  },
                  isShowErrorMessage: true,
                  validType: ValidType.password,
                  isPassword: true,
                  focusNode: _passwordFocus,
                  controller: _passwordController,
                  labelText: "key_password".tr(),
                  prefixIcon: const Icon(Icons.lock_outlined),
                  onFieldSubmitted: (val) {
                    _submit();
                  },
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                  isEnable: _isValidPassword & _isValidEmail,
                  text: "key_login".tr(),
                  onPressed: _submit,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          NavigationService.instance
                              .push(const ForgotPassword());
                        },
                        child: Text(
                          "key_forgot_password".tr(),
                          style: AppTextStyles.textSize20(
                              color: AppColor.secondary),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Đăng nhập với | ',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn không có tài khoản? ",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                30.h,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
