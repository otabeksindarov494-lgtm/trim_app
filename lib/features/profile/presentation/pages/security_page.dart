import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class Podcast {
  final String text;
  bool isEnabled;

  Podcast({required this.text, this.isEnabled = false});
}

final List<Podcast> podcast = [
  Podcast(text: 'Запомнить меня'),
  Podcast(text: 'Face ID'),
  Podcast(text: 'Отпечатка пальцев'),
];

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 84.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 28.w),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/img_5.png',
                    width: 28.w,
                    height: 28.h,
                    color: context.theme.textPrimary,
                  ),
                ),
                SizedBox(width: 20.w),
                Text(
                  'Безопастность',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 0.h),
                itemCount: podcast.length,
                separatorBuilder: (_, __) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final podcasts = podcast[index];
                  return Row(
                    children: [
                      Text(
                        podcasts.text,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: context.theme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 24.w),
                        child: CupertinoSwitch(
                          activeTrackColor: const Color(0xffF49803),
                          value: podcasts.isEnabled,
                          onChanged: (bool? value) {
                            setState(() {
                              podcasts.isEnabled = value ?? false;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 32.h),
            GlassContainer(
              width: 380.w,
              height: 56.h,
              borderRadius: BorderRadius.circular(100.r),
              blur: 16,
              borderColor: const Color(0xffFF9500).withValues(alpha: 0.35),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xffFF9500).withValues(alpha: 0.18),
                  const Color(0xffFF9500).withValues(alpha: 0.05),
                ],
              ),
              child: const Center(
                child: Text(
                  "Изменить PIN",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFF9500),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            GlassContainer(
              width: 380.w,
              height: 56.h,
              borderRadius: BorderRadius.circular(100.r),
              blur: 16,
              borderColor: const Color(0xffFF9500).withValues(alpha: 0.35),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xffFF9500).withValues(alpha: 0.18),
                  const Color(0xffFF9500).withValues(alpha: 0.05),
                ],
              ),
              child: const Center(
                child: Text(
                  "Изменить пароль",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFF9500),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
