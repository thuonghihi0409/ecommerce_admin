import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/login_page.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/conversation_page.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:thuongmaidientu/features/notification/presentation/bloc/notification_bloc/notification_bloc.dart';
import 'package:thuongmaidientu/features/order_management.dart/presentation/page/order_management_page.dart';
import 'package:thuongmaidientu/features/product/presentation/page/product_page.dart';
import 'package:thuongmaidientu/features/product/presentation/page/store_detail.dart';
import 'package:thuongmaidientu/features/product_management/presentation/page/category_management.dart';
import 'package:thuongmaidientu/features/product_management/presentation/page/create_product_page.dart';
import 'package:thuongmaidientu/features/product_management/presentation/page/product_management_page.dart';
import 'package:thuongmaidientu/features/product_management/presentation/page/product_restock_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/page/setting_screen.dart';
import 'package:thuongmaidientu/features/store_management/presentation/page/store_management_page.dart';
import 'package:thuongmaidientu/features/user_management/presentation/page/user_management_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/badge_icon.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';

List<String> drawers = [
  'key_dashboard'.tr(),
  "key_category_management".tr(),
  'key_product_management'.tr(),
  'key_order_management'.tr(),
  'key_user_management'.tr(),
  'key_store_management'.tr(),
  'key_setting'.tr(),
];

List<String> drawerIcons = [
  AppAssets.dashboardIcon,
  AppAssets.categoryIcon,
  AppAssets.productIcon,
  AppAssets.orderIcon,
  AppAssets.addUserIcon,
  AppAssets.storeIcon,
  AppAssets.settingIcon,
];

List<String> drawerRoutes = [
  "dashboard",
  "category_management",
  "product_management",
  "order_management",
  "user_management",
  "store_management",
  "setting",
];

class WebMainDrawer extends StatefulWidget {
  const WebMainDrawer({super.key});

  @override
  State<WebMainDrawer> createState() => _WebMainDrawerState();
}

class _WebMainDrawerState extends State<WebMainDrawer> {
  String _routeSelected = "";

  _logout() {
    Helper.showCustomDialog(
        context: context,
        onPressPrimaryButton: () {
          context.read<AuthBloc>().add(AuthLogout(onSuccess: () {
            NavigationService.instance
                .popUntilRootAndReplace(const LoginScreen());
          }));
        },
        message: "key_confirm_logout".tr(),
        isShowSecondButton: true,
        isShowPrimaryButton: true,
        onPressSecondButton: () {
          NavigationService.instance.goBack();
        });
  }

  Widget _buildItem(
      {required String iconPath,
      required String title,
      required String route,
      EdgeInsets? paddingIcon,
      Function()? onTap,
      double? size}) {
    bool isSelected = _routeSelected == route;
    bool isCollapsed = context.widthScreen < 1000;
    return Material(
      color:
          isSelected ? AppColor.greyColor.withAlpha(100) : Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
            return;
          }
          if (_routeSelected == route) {
            return;
          }

          setState(() {
            _routeSelected = route;
          });
          NavigationService.instance.replaceNamed(route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          child: Row(
            mainAxisAlignment: isCollapsed
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 40,
                  padding: paddingIcon,
                  alignment: isCollapsed ? Alignment.center : null,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        width: size ?? 30,
                        colorFilter: ColorFilter.mode(
                            isSelected ? AppColor.primary : AppColor.greyColor,
                            BlendMode.srcIn),
                      ),
                      if (route == "notification")
                        BlocBuilder<NotificationBloc, NotificationState>(
                          builder: (context, state) {
                            if (0 == 0) {
                              return const SizedBox();
                            }

                            return const Positioned(
                                right: 18,
                                child: BadgeIcon(
                                    icon: Icon(Icons.notification_add)));
                          },
                        )
                    ],
                  )),
              if (isCollapsed == false)
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.textSize14(
                      color:
                          isSelected ? AppColor.primary : AppColor.blackColor,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Row(children: [
                /// Same size drawer
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: context.widthScreen * 0.2,
                ),
                Expanded(
                  child: Navigator(
                    observers: [NavigationService.instance.routeObserver],
                    initialRoute: 'dashboard',
                    onGenerateRoute: (RouteSettings settings) {
                      Widget child = const ProductPage();
                      switch (settings.name) {
                        case "dashboard":
                          child = const DashboardPage();
                          break;
                        case "product_management":
                          child = const ProductManagementPage();
                          break;
                        case "setting":
                          child = const AccountSettingsScreen();
                          break;
                        case "product_detail":
                          child = const ProductPage();
                          break;
                        case "conversation":
                          child = const ConversationPage();
                          break;
                        case "create_product":
                          child = const CreateProductPage();
                          break;
                        case "order_management":
                          child = const OrderManagementPage();
                          break;
                        case "product_restock":
                          child = const ProductRestockPage();
                          break;
                        case "profile_store":
                          child = StoreDetail(
                              store: context.read<ProfileBloc>().state.store);
                          break;
                        case "user_management":
                          child = const UserManagementPage();
                          break;
                        case "store_management":
                          child = const StoreManagementPage();
                          break;
                        case "category_management":
                          child = const CategoryManagementPage();
                          break;
                      }

                      return MaterialPageRoute(builder: (_) => child);
                    },
                  ),
                )
              ]),
            ),

            /// ============================================================
            /// ======================== DRAWER ============================
            /// ============================================================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              width:
                  context.widthScreen > 1000 ? context.widthScreen * 0.2 : 120,
              color: AppColor.greyColor.withAlpha(50),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      NavigationService.instance.pushNamed("profile_store");
                    },
                    child: Row(
                      children: [
                        10.w,
                        context.read<ProfileBloc>().state.store?.logoUrl == null
                            ? SvgPicture.asset(
                                AppAssets.addUserIcon,
                                height: 50,
                                width: 50,
                              )
                            : CustomCacheImageNetwork(
                                height: 50,
                                width: 50,
                                borderRadius: 25,
                                imageUrl: context
                                    .read<ProfileBloc>()
                                    .state
                                    .store
                                    ?.logoUrl),
                        10.w,
                        Expanded(
                            child: Text(
                          "key_admin_user".tr(),
                          style: AppTextStyles.textSize18(
                              fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                  36.h,
                  Expanded(
                    child: Column(
                      children: drawers
                          .asMap()
                          .entries
                          .map(
                            (drawer) => _buildItem(
                              route: drawerRoutes[drawer.key],
                              iconPath: drawerIcons[drawer.key],
                              title: drawer.value.toUpperCase(),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  _buildItem(
                    route: '',
                    iconPath: AppAssets.loginIcon,
                    title: 'key_sign_out'.tr().toUpperCase(),
                    onTap: _logout,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
