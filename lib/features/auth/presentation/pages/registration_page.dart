import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/auth/presentation/pages/phone_page.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/auth/presentation/pages/email_page.dart';
import 'package:trim_app/theme/app_theme.dart';

import '../../../../widgets/common/glass.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, required this.listImage});
  final List<ListImage> listImage;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isPhone = true;

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
                      child: Image.asset('assets/images/img_5.png', width: 28.w, height: 28.h, color: context.theme.textPrimary,)),
                  SizedBox(width: 16.w),
                  Text(
                    'Регистрация',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'bold',
                      color: context.theme.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 65.h),
              Center(
                child: Image.asset(
                  'assets/images/img_4.png',
                  width: 192.w,
                  height: 169.h,
                ),
              ),
              SizedBox(height: 32.h),
              GlassContainer(
                width: 380.w,
                height: 53.h,
                  borderRadius: BorderRadius.circular(30.r),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPhone = true;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: isPhone
                                ? const Color(0xFFFEA325)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Телефон",
                            style: TextStyle(
                              color: isPhone ? Colors.white : context.theme.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'regular',
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPhone = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: !isPhone
                                ? const Color(0xFFFEA325)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Почта",
                            style: TextStyle(
                              color: !isPhone ? Colors.white : context.theme.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'regular',
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              if (isPhone)
                PhonePage(listImage: widget.listImage)
              else
                EmailPage(listImage: widget.listImage),
            ],
          ),
        ),
      ),
    );
  }
}
