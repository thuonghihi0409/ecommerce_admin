import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/login_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/chat_bot_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/purchase_history_screen.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/setting_screen.dart';
import 'package:thuongmaidientu/shared/service/firebase_service.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late ProfileBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ProfileBloc>();
  }

  _onLogout() {
    context.read<AuthBloc>().add(AuthLogout(onSuccess: () {
      NavigationService.instance.popUntilRootAndReplace(const LoginScreen());
    }));
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
            title: "key_setting".tr(),
            showLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar và tên người dùng
                  Stack(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: CustomCacheImageNetwork(
                            imageUrl: state.profile?.image,
                            height: 80,
                            width: 80,
                            borderRadius: 40,
                            errorWidget: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Center(
                                  child: Text(
                                (state.profile?.name ?? "T")
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: AppTextStyles.textSize30(
                                    color: AppColor.whiteColor),
                              )),
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                Helper.showImagePickerDialog(
                                  isOne: true,
                                  context,
                                  onPicker: (path) async {
                                    if (path != null) {
                                      try {
                                        final imageUrl = await FirebaseService
                                            .instance
                                            .uploadImages(File(path));
                                        _bloc.add(UpdateProfile(
                                            profile: state.profile!
                                                .copyWith(image: imageUrl)));
                                      } catch (e) {
                                        Helper.showToastBottom(
                                            message:
                                                ParseError.fromJson(e).message);
                                      }
                                    }
                                  },
                                  onCamera: (path) async {
                                    if (path != null) {
                                      try {
                                        final imageUrl = await FirebaseService
                                            .instance
                                            .uploadImages(File(path));
                                        _bloc.add(UpdateProfile(
                                            profile: state.profile!
                                                .copyWith(image: imageUrl)));
                                      } catch (e) {
                                        Helper.showToastBottom(
                                            message:
                                                ParseError.fromJson(e).message);
                                      }
                                    }
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                              ))),
                    ],
                  ),
                  20.h,
                  Text(
                    state.profile?.name ?? "", // Thay bằng tên người dùng
                    style:
                        AppTextStyles.textSize20(fontWeight: FontWeight.bold),
                  ),
                  10.h,
                  Text(
                    state.profile?.email ?? "", // Thay bằng email người dùng
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Divider(height: 32, color: Colors.grey[400]),

                  // Danh sách các tùy chọn
                  _buildAccountOption(
                      Icons.settings, "key_account_setting".tr(), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AccountSettingsScreen()));
                  }),
                  _buildAccountOption(Icons.history, "key_history".tr(), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PurchaseHistoryScreen()));
                  }),
                  _buildAccountOption(Icons.favorite, "key_list_favorite".tr(),
                      () {
                    // Xử lý nhấn vào
                  }),
                  _buildAccountOption(Icons.location_on, "key_address".tr(),
                      () {
                    // Xử lý nhấn vào
                  }),
                  _buildAccountOption(Icons.help_outline, "key_help".tr(), () {
                    NavigationService.instance.push(const GeminiChatPage());
                  }),
                  Divider(height: 32, color: Colors.grey[400]),
                  CustomButton(
                    text: "key_logout".tr(),
                    onPressed: _onLogout,
                  ),
                  20.h,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAccountOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
