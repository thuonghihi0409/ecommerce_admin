import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_life_cycle_handle.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/login_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';
import 'package:thuongmaidientu/web_main_drawer.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  const VerifyPage({super.key, required this.email});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  int _remainingTime = 60;
  Timer? _timer;
  late final AppLifecycleHandler _handler;

  @override
  void initState() {
    super.initState();
    _submit();
    _handler = AppLifecycleHandler(onResumed: () async {
      final user = FirebaseAuth.instance.currentUser;
      await user?.reload();
      final isVerified = user?.emailVerified ?? false;

      if (isVerified && mounted) {
        context.read<ProfileBloc>().add(GetProfile(
            email: widget.email,
            onSuccess: () async {
              NavigationService.instance
                  .popUntilRootAndReplace(const WebMainDrawer());
            }));
      }
    });
    WidgetsBinding.instance.addObserver(_handler);
    _startCountdown();
  }

  void _startCountdown() {
    setState(() => _remainingTime = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
      } else {
        if (!mounted) return;
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_handler);
    super.dispose();
  }

  void _submit() {
    context.read<AuthBloc>().add(AuthSendVerifyEmail(email: widget.email));
    _startCountdown();
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
          title: "key_verify_email".tr(),
          isShowCartIcon: false,
          isShowChatIcon: false,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return Padding(
            padding: kIsWeb
                ? EdgeInsets.symmetric(
                    horizontal: context.widthScreen > 1000
                        ? context.widthScreen * 0.2
                        : context.widthScreen * 0.1)
                : const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.securityIcon,
                  height: 80,
                  width: 80,
                  colorFilter:
                      const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
                ),
                50.h,
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: "key_check_your_email".tr(),
                      style: AppTextStyles.textSize18(),
                      children: [
                        TextSpan(
                            text: widget.email,
                            style: AppTextStyles.textSize18(
                                color: AppColor.greyColor))
                      ]),
                ),
                50.h,
                CustomButton(
                  text: _remainingTime > 0
                      ? "${"key_resend".tr()} ($_remainingTime s)"
                      : "key_resend".tr(),
                  onPressed: _remainingTime > 0 ? null : _submit,
                ),
                20.h,
                CustomButton(
                  text: "key_cancel",
                  onPressed: () {
                    NavigationService.instance
                        .goBack(result: const LoginScreen());
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
