import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/profile/servise_widget.dart';
import '../bloc/model/subscription_model.dart';
import '../profile/action_page.dart';
import '../profile/profile_page.dart';
import '../home_page.dart';
import 'package:collection/collection.dart';

import '../sign_in_page.dart';
part 'app_router.gr.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: ProfileRoute.page),
  ];
}