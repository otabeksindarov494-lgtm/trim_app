import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/home_menu.dart';

import '../bloc/model/subscription_model.dart';

class AboutWidget extends StatefulWidget {
  final Subscriptions profile;

  const AboutWidget({super.key, required this.profile});

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                  'Lorem ipsum dolor sit amet consectetur. '
                      'Sit a pellentesque interdum augue fames ultrices in sem. '
                      'Ultricies tempus faucibus morbi aliquet ut tellus ut. '
                      'Nulla at consectetur non sed posuere lacinia. Viverra vel in mauris eget sit id facilisis.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff616161),
                  ),
                ),
                TextSpan(
                  text: 'Подробнее ...',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffFD9301),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Рабочее время',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Понедельник - Пятница',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Color(0xff616161),
              ),
            ),
            SizedBox(width: 34.w),
            Text(':', textAlign: TextAlign.center),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 70.w),
              child: Text(
                '09:00 - 20:00',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Суббота - Воскресенье',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: Color(0xff616161),
              ),
            ),
            SizedBox(width: 41.w),
            Text(':', textAlign: TextAlign.center),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 70.w),
              child: Text(
                '10:00 - 19:00',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Контакты',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              '+998 99 999-99-99',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xffFFAB38),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Наш адресс',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: Text(
                'На карте',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFFAB38),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        Row(
          children: [
            SizedBox(width: 24.w),
            Image.asset(
              'assets/images/img_24.png',
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 16.w),
            Text(
              widget.profile.podcastCount,
              style: TextStyle(color: Color(0xff616161)),
            ),
          ],
        ),
        SizedBox(height: 27.h),
        Image.asset('assets/images/img_47.png', width: 380.w, height: 380.h),
      ],
    );
  }
}
