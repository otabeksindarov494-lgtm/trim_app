import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trim_app/features/profile/presentation/pages/friends_page.dart';
import 'package:trim_app/features/profile/presentation/pages/social_page.dart';
import 'package:trim_app/core/l10n/app_localizations.dart';
import 'package:trim_app/core/l10n/language_cubit.dart';
import 'package:trim_app/core/theme/theme_cubit.dart';
import 'package:trim_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trim_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:trim_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:trim_app/features/profile/presentation/pages/edit_profile.dart';
import 'package:trim_app/features/profile/presentation/pages/language_page.dart';
import 'package:trim_app/features/profile/presentation/pages/notification_page.dart';
import 'package:trim_app/features/profile/presentation/pages/security_page.dart';
import 'package:trim_app/theme/app_theme.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  String? profileId;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    profileId = user.uid;
    if (!mounted) return;

    context.read<ProfileBloc>().add(
      LoadProfile(profileId: profileId!),
    );
  }

  List<Map<String, dynamic>> _getSettings(
      BuildContext context, String currentLangCode) {
    final langTitle = currentLangCode == 'uz'
        ? context.tr('uzbek')
        : context.tr('russian');

    return [
      {
        "title": context.tr('edit_profile'),
        "icon": "assets/images/img_79.png",
        "type": "arrow",
      },
      {
        "title": context.tr('notifications'),
        "icon": "assets/images/img_80.png",
        "type": "arrow",
      },
      {
        "title": context.tr('security'),
        "icon": "assets/images/img_81.png",
        "type": "arrow",
      },
      {
        "title": context.tr('privacy_policy'),
        "icon": "assets/images/img_82.png",
        "type": "arrow",
      },
      {
        "title": context.tr('invite_friends'),
        "icon": "assets/images/img_83.png",
        "type": "arrow",
      },
      {
        "title": context.tr('language'),
        "icon": "assets/images/img_84.png",
        "type": "language",
        "value": langTitle,
      },
      {
        "title": context.tr('dark_mode'),
        "icon": "assets/images/img_85.png",
        "type": "switch",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LanguageCubit>().state;
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;
    final settingsList = _getSettings(context, currentLocale.languageCode);

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileError) {
          return Center(
            child: Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(color: context.theme.textPrimary),
            ),
          );
        }

        if (state is ProfileLoaded) {
          final profile = state.profile;

          return Scaffold(
            backgroundColor: context.theme.background,
            body: Padding(
              padding: EdgeInsets.only(top: 70.h, left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/img_9.png',
                        width: 34.w,
                        height: 34.h,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        context.tr('profile'),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: context.theme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/img_30.png',
                        width: 28.w,
                        height: 28.h,
                        color: context.theme.textPrimary,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/img_78.png',
                        width: 120.w,
                        height: 120.h,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 70.h),
                          child: Text(
                            '${profile.name} ${profile.nickName}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: context.theme.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 100.h),
                      itemCount: settingsList.length,
                      itemBuilder: (context, index) {
                        final item = settingsList[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: GestureDetector(
                            onTap: () async {
                              switch (index) {
                                case 0:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const EditProfile(),
                                    ),
                                  );
                                  loadProfile();
                                  break;
                                case 1:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const NotificationPage(),
                                    ),
                                  );
                                  break;
                                case 2:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SecurityPage(),
                                    ),
                                  );
                                  break;
                                case 3:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SocialPage(),
                                    ),
                                  );
                                  break;
                                case 4:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const FriendsPage(),
                                    ),
                                  );
                                  break;
                                case 5:
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LanguagePage(),
                                    ),
                                  );
                                  break;
                              }
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  item["icon"],
                                  width: 28.w,
                                  height: 28.h,
                                  color: context.theme.textPrimary,
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    item["title"],
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: context.theme.textPrimary,
                                    ),
                                  ),
                                ),
                                if (item["type"] == "language") ...[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFF4E5),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item["value"],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xffFF9500),
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 18.sp,
                                          color: const Color(0xffFF9500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ] else if (item["type"] == "switch") ...[
                                  CupertinoSwitch(
                                    activeTrackColor: const Color(0xffF49803),
                                    value: isDark,
                                    onChanged: (bool value) {
                                      context
                                          .read<ThemeCubit>()
                                          .toggleTheme(value);
                                    },
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.chevron_right,
                                    color: context.theme.textPrimary,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
