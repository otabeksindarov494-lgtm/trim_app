import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/theme/app_theme.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
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
                SizedBox(width: 24.w),
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
                SizedBox(width: 16.w),
                Text(
                  'Конфидециалность',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
