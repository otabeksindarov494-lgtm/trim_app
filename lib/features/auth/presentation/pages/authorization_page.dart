import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/auth/presentation/widgets/email_widget.dart';
import 'package:trim_app/features/auth/presentation/widgets/phone_widget.dart';
import 'package:trim_app/core/l10n/app_localizations.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key, required this.listImage});
  final List<ListImage> listImage;

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  bool isPhone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 77.h),
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
                    child: Image.asset('assets/images/img_5.png', width: 28.w, height: 28.h),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    context.tr('authorization'),
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, fontFamily: 'bold', color: context.theme.textPrimary),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
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
                            color: isPhone ? const Color(0xFFFEA325) : Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            context.tr('phone'),
                            style: TextStyle(
                              color: isPhone ? Colors.white : context.theme.textSecondary,
                              fontWeight: FontWeight.w600,
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
                            color: !isPhone ? const Color(0xFFFEA325) : Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            context.tr('email'),
                            style: TextStyle(
                              color: !isPhone ? Colors.white : context.theme.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              if (isPhone)
                PhoneWidget(listImage: widget.listImage)
              else
                EmailWidget(listImage: widget.listImage),
            ],
          ),
        ),
      ),
    );
  }
}
