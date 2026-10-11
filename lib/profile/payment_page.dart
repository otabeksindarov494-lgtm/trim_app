import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/profile/check_page.dart';

import '../bloc/model/subscription_model.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.cheks,
    required this.listImage,
    required this.bookingDate,
    required this.bookingTime,
    required this.masterId,
    required this.masterName,
  });

  final Subscriptions cheks;
  final List<ListImage> listImage;
  final DateTime bookingDate;
  final String bookingTime;
  final String masterId;
  final String masterName;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 70.h),
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
                  ),
                ),
                SizedBox(width: 24.w),
                Text(
                  'Оплата',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.h),
            Text(
              'Выберите удобный для вас способ оплаты',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = 0;
                });
              },
              child: Container(
                width: 380.w,
                height: 72.h,
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
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 24.w),
                      Image.asset(
                        'assets/images/img_73.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Оплата наличными',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 24.w),
                        child: isSelected == 0
                            ? Image.asset(
                                'assets/images/img_75.png',
                                width: 24.w,
                                height: 24.h,
                              )
                            : Image.asset(
                                'assets/images/img_74.png',
                                width: 24.w,
                                height: 24.h,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = 1;
                });
              },
              child: Container(
                width: 380.w,
                height: 72.h,
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
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 24.w),
                      Image.asset(
                        'assets/images/img_76.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Оплата картой',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 24.r),
                        child: isSelected == 1
                            ? Image.asset(
                                'assets/images/img_75.png',
                                width: 24.w,
                                height: 24.h,
                              )
                            : Image.asset(
                                'assets/images/img_74.png',
                                width: 24.w,
                                height: 24.h,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 459.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckPage(
                      check: widget.cheks,
                      listImage: widget.listImage,
                      bookingDate: widget.bookingDate,
                      bookingTime: widget.bookingTime,
                      masterId: widget.masterId,
                      masterName: widget.masterName,
                      paymentMethod: isSelected == 0 ? 'cash' : 'card',
                    ),
                  ),
                );
              },
              child: Container(
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
                    'Далее',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
