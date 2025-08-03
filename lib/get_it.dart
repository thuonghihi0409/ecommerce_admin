import 'package:get_it/get_it.dart';
import 'package:thuongmaidientu/features/auth/di/auth_dependecy.dart';
import 'package:thuongmaidientu/features/chat/di/chat_dependecy.dart';
import 'package:thuongmaidientu/features/dashboard/di/dashboard_dependecy.dart';
import 'package:thuongmaidientu/features/order_management.dart/di/order_management_dependecy.dart';
import 'package:thuongmaidientu/features/product/di/product_dependecy.dart';
import 'package:thuongmaidientu/features/product_management/di/product_management_dependecy.dart';
import 'package:thuongmaidientu/features/profile/di/profile_dependecy.dart';
import 'package:thuongmaidientu/features/review/di/review_dependecy.dart';
import 'package:thuongmaidientu/features/store_management/di/store_management_dependecy.dart';
import 'package:thuongmaidientu/features/user_management/di/user_management_dependecy.dart';

final sl = GetIt.instance;

Future<void> init() async {
  AuthDependecy.init();
  UserManagementDependecy.init();
  ChatDependecy.init();
  ProductDependecy.init();
  ProfileDependecy.init();
  ReviewDependecy.init();
  DashboardDependecy.init();
  OrderManagementDependecy.init();
  ProductManagementDependecy.init();
  StoreManagementDependecy.init();
}
