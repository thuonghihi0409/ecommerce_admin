import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/change_password_screen.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/update_profile_screen.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  AccountSettingsScreenState createState() => AccountSettingsScreenState();
}

class AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isShowCartIcon: false,
        isShowChatIcon: false,
        showLeading: !kIsWeb,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cập nhật thông tin cá nhân
            ListTile(
              title: Text(
                "key_update_information".tr(),
                style: AppTextStyles.textSize20(),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
              onTap: () {
                NavigationService.instance.push(const UpdateProfileScreen());
              },
            ),
            20.h,

            // Đổi mật khẩu
            ListTile(
              title: Text(
                "key_change_password".tr(),
                style: AppTextStyles.textSize20(),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
              onTap: () {
                NavigationService.instance.push(const ChangePasswordScreen());
              },
            ),
            20.h,

            SwitchListTile(
              title: Text('Chế độ tối', style: AppTextStyles.textSize20()),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                  // Chuyển giữa chế độ sáng và tối
                });
              },
            ),
            const SizedBox(height: 20),

            SwitchListTile(
              title: Text('Bật thông báo', style: AppTextStyles.textSize20()),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
