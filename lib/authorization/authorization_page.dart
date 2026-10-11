import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/authorization/email_widget.dart';
import 'package:trim_app/authorization/phone_widget.dart';
import 'package:trim_app/profile/action_page.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key, required this.listImage});
  final  List <ListImage> listImage;

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  bool isPhone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      child: Image.asset('assets/images/img_5.png', width: 28.w, height: 28.h)),
                  SizedBox(width: 16.w),
                  Text(
                    'Авторизация',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, fontFamily: 'bold'),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Container(
                width: 380.w,
                height: 53.h,
                decoration: BoxDecoration(
                  color: Color(0xffFAFAFA),
                  borderRadius: BorderRadius.circular(30.r),
                ),
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
                              color: isPhone ? Colors.white : Color(0xff9E9E9E),
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
                            color: !isPhone
                                ? const Color(0xFFFEA325)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Почта",
                            style: TextStyle(
                              color: !isPhone ? Colors.white : Color(0xff9E9E9E),
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
                PhoneWidget(listImage: widget.listImage,)
              else
                EmailWidget(listImage: widget.listImage,),
            ],
          ),
        ),
      ),
    );
  }
}
