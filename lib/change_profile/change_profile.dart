import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trim_app/change_profile/friends_page.dart';
import 'package:trim_app/change_profile/social_page.dart';
import '../bloc/provider/profile_bloc.dart';
import '../bloc/provider/profile_event.dart';
import '../bloc/provider/profile_state.dart';
import 'edit_profile.dart';
import 'language_page.dart';
import 'notification_page.dart';
import 'security_page.dart';

List<Map<String, dynamic>> settings = [
  {
    "title": "Изменить профиль",
    "icon": "assets/images/img_79.png",
    "type": "arrow",
  },
  {"title": "Уведомление", "icon": "assets/images/img_80.png", "type": "arrow"},
  {
    "title": "Безопасность",
    "icon": "assets/images/img_81.png",
    "type": "arrow",
  },
  {
    "title": "Политика конфиденциальности",
    "icon": "assets/images/img_82.png",
    "type": "arrow",
  },
  {
    "title": "Пригласить друзей",
    "icon": "assets/images/img_83.png",
    "type": "arrow",
  },
  {
    "title": "Язык",
    "icon": "assets/images/img_84.png",
    "type": "language",
    "value": "English (US)",
  },
  {
    "title": "Темная версия",
    "icon": "assets/images/img_85.png",
    "type": "switch",
  },
];

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  bool isDarkMode = false;
  bool isEnabled = false;

  String? profileId;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return;
    }

    profileId = user.id;

    if (!mounted) return;

    context.read<ProfileBloc>().add(
      LoadProfile(profileId: profileId!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
              child: CircularProgressIndicator(),
            );
        }

        if (state is ProfileError) {
          return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
            );
        }

        if (state is ProfileLoaded) {
          final profile = state.profile;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding:  EdgeInsets.only(top: 70.h, left: 24.w, right: 24.w),
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
                        'Профиль',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/img_30.png',
                        width: 28.w,
                        height: 28.h,
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
                            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 100.h),
                      itemCount: settings.length,
                      itemBuilder: (context, index) {
                        final item = settings[index];
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

                                case 7:
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Container(
                                        height: 280.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(32.r),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 12.h),

                                            Container(
                                              width: 40.w,
                                              height: 4.h,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                BorderRadius.circular(10.r),
                                              ),
                                            ),

                                            SizedBox(height: 30.h),

                                            Text(
                                              "Выйти",
                                              style: TextStyle(
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(height: 24.h),
                                            Divider(
                                              height: 1.h,
                                              thickness: 2,
                                              endIndent: 20,
                                              indent: 20,
                                              color: Color(0xffEEEEEE),
                                            ),

                                            SizedBox(height: 24.h),

                                            Text(
                                              'Вы уверены что хотите выйти',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                            SizedBox(height: 24.h),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 184.w,
                                                  height: 56.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      100.r,
                                                    ),
                                                    color: Color(0xffF5E7FF),
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Отмена',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Color(
                                                          0xffFD9301,
                                                        ).withOpacity(0.1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                Container(
                                                  width: 184.w,
                                                  height: 56.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      100.r,
                                                    ),
                                                    color: Color(0xffFD9301),
                                                  ),
                                                  child: ElevatedButton(
                                                    style:
                                                    ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      Colors.transparent,
                                                    ),
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Да, уверен',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  break;
                              }
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                    item["icon"], width: 28.w, height: 28.h),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    item["title"],
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                if (item["type"] == "language") ...[
                                  Text(
                                    item["value"],
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(Icons.chevron_right),
                                ] else
                                  if (item["type"] == "switch") ...[
                                    CupertinoSwitch(
                                      activeTrackColor: Color(0xffF49803),
                                      value: isEnabled,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isEnabled = value ?? false;
                                        });
                                      },
                                    ),
                                  ] else
                                    ...[
                                      const Icon(Icons.chevron_right),
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
        if (state is ProfileUpdating) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
