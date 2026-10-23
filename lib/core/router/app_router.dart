import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:trim_app/features/home/presentation/pages/splash_page.dart';
import 'package:trim_app/features/profile/presentation/pages/profile_page.dart';
import 'package:trim_app/features/home/presentation/pages/home_page.dart';
import 'package:trim_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/salon/presentation/widgets/servise_widget.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:collection/collection.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: ProfileRoute.page),
  ];
}
