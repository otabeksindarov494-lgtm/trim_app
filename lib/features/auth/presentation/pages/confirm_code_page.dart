import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:trim_app/features/auth/presentation/pages/new_password_page.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/theme/app_theme.dart';

class ConfirmCodePage extends StatefulWidget {
  final String amount;
  final List<ListImage> listImage;

  const ConfirmCodePage({super.key, required this.amount, required this.listImage});

  @override
  State<ConfirmCodePage> createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  int seconds = 60;
  Timer? timer;

  void startTimer() {
    timer?.cancel();
    seconds = 60;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 84.h),
        child: SingleChildScrollView(
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
                  SizedBox(width: 16.w),
                  Text(
                    'Забыл пароль',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'bold',
                      color: context.theme.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 234.h),
              Center(
                child: Text(
                  'Код отправлен на номер \n${widget.amount}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: context.theme.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              Pinput(
                length: 4,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 83.w,
                  height: 61.h,
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.inputBackground,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),

                focusedPinTheme: PinTheme(
                  width: 83.w,
                  height: 61.h,
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFAB38).withOpacity(0.1),
                    border: Border.all(color: const Color(0xffFFAB38), width: 2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              GestureDetector(
                onTap: seconds == 0
                    ? () {
                        startTimer();
                      }
                    : null,
                child: Text(
                  seconds > 0
                      ? "Повторно отправить код через $seconds сек."
                      : "Повторно отправить код",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: context.theme.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 190.h),
              Container(
                width: 358.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  gradient: const LinearGradient(
                    colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPasswordPage(listImage: widget.listImage),
                        ),
                      );
                    },
                    child: Text(
                      'Подтвердить',
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
      ),
    );
  }
}
