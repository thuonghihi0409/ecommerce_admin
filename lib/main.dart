import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:thuongmaidientu/features/order_management.dart/presentation/bloc/order_management_bloc/order_management_bloc.dart';
import 'package:thuongmaidientu/features/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/review/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:thuongmaidientu/features/store_management/presentation/bloc/store_management_bloc/store_management_bloc.dart';
import 'package:thuongmaidientu/features/user_management/presentation/bloc/user_management_bloc/user_management_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';
import 'package:thuongmaidientu/init_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: dotenv.env["FIREBASE_KEY"]!,
          authDomain: "timtro-f9635.firebaseapp.com",
          projectId: "timtro-f9635",
          storageBucket: "timtro-f9635.appspot.com",
          messagingSenderId: "932058865237",
          appId: "1:932058865237:web:b9d460f351c9ed037c7edc",
          measurementId: "G-9GX3B2VG6P" // Optional
          ),
    );
  } else {
    await Firebase.initializeApp();
  }
  FirebaseAuth.instance.setLanguageCode('vi');
  await Supabase.initialize(
      anonKey: dotenv.env["SUPABASE_KEY"]!,
      url: dotenv.env["SUPABASE_URL"]!,
      debug: true);
  init(); // get it
  // await generateEmbeddings();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
      startLocale: const Locale('vi'),
      child: OverlaySupport.global(
        // to show toast
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => sl<AuthBloc>()),
          BlocProvider(create: (_) => sl<ReviewBloc>()),
          BlocProvider(create: (_) => sl<ProfileBloc>()),
          BlocProvider(create: (_) => sl<DashboardBloc>()),
          BlocProvider(create: (_) => sl<ProductManagementBloc>()),
          BlocProvider(create: (_) => sl<OrderManagementBloc>()),
          BlocProvider(create: (_) => sl<UserManagementBloc>()),
          BlocProvider(create: (_) => sl<StoreManagementBloc>()),
        ], child: const MyApp()),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log('🟡 Current locale: ${context.locale}');

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        navigatorKey: NavigationService.instance.navigatorKey,
        theme: ThemeData(
          useMaterial3: true, //
          // primarySwatch: Colors.blue,
          // brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
            // primarySwatch: Colors.blue,
            // brightness: Brightness.dark,
            ),
        // themeMode: ThemeMode.system,

        home: const InitPage(),
      ),
    );
  }
}
