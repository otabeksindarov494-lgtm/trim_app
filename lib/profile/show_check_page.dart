import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/profile/action_page.dart';

import '../bloc/model/subscription_model.dart';

class ShowCheckPage extends StatefulWidget {
  const ShowCheckPage({super.key, required this.showCheck, required this.listImage});

  final Subscriptions showCheck;
  final  List <ListImage> listImage;

  @override
  State<ShowCheckPage> createState() => _ShowCheckPageState();
}

class _ShowCheckPageState extends State<ShowCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 77.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 24.w),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeMenu(listImage: widget.listImage,)),
                    );
                  },
                  child: Image.asset(
                    'assets/images/img_5.png',
                    width: 28.w,
                    height: 28.h,
                  ),
                ),
                SizedBox(width: 24.w),
                Text(
                  'Чек',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 33.h),
            Center(
              child: Image.asset(
                'assets/images/img_77.png',
                width: 211.w,
                height: 120.h,
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: 380.w,
              height: 344.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffE9E9E9),
                    blurRadius: 24.r,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Барбер/Салон',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.showCheck.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Адресс',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.showCheck.podcastCount,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Имя',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Otabek',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Номер',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '+998 99 999-99-99',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Дата заказа',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '15 Август 2024',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Время заказа',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '11:00',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
                    child: Row(
                      children: [
                        Text(
                          'Исполнитель',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Ходжиакбар',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 195.h),
            Container(
              width: 380.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                gradient: LinearGradient(
                  colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                ),
              ),
              child: Center(
                child: Text(
                  'Скачать чек',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
