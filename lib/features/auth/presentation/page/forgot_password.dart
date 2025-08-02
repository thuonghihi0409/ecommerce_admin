import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart'
    show CustomAppBar;
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/textfield_custom.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPassword> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("Vui lòng kiểm tra email để đặt lại mật khẩu!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "key_forgot_password".tr(),
        isShowCartIcon: false,
        isShowChatIcon: false,
      ),
      body: SingleChildScrollView(
        padding: kIsWeb
            ? EdgeInsets.symmetric(
                horizontal: context.widthScreen > 1000
                    ? context.widthScreen * 0.2
                    : context.widthScreen * 0.1)
            : const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            50.h,
            Text(
              "key_reset_password".tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            30.h,
            CustomTextField(
              labelText: "key_email".tr(),
              prefixIcon: const Icon(Icons.email_outlined),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                return;
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "key_send_request".tr(),
              onPressed: _submit,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "key_back_login".tr(),
                style: AppTextStyles.textSize18(color: AppColor.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
