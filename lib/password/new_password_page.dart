import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trim_app/home_menu/navigation_page.dart';
import 'package:trim_app/profile/action_page.dart';


class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key, required this.listImage});
  final  List <ListImage> listImage;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Создайте новый пароль',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
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
            SizedBox(height: 50.h),
            Row(
              children: [
                SizedBox(width: 24.w),
                Text(
                  'Введите пароль',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              width: 380.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Color(0xffFAFAFA),
                border: Border.all(color: Color(0xffEEEEEE)),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: TextField(
                    obscureText: true,
                    obscuringCharacter: '⚫',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Пароль",
                      hintStyle: TextStyle(
                        color: Color(0xff677294),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                SizedBox(width: 24.w),
                Text(
                  'Подтвердить пароль',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              width: 380.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Color(0xffFAFAFA),
                border: Border.all(color: Color(0xffEEEEEE)),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: TextField(
                    obscureText: true,
                    obscuringCharacter: '⚫',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Пароль',
                      hintStyle: TextStyle(
                        color: Color(0xff677294),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 190.h),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        width: 340.w,
                        height: 487.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(48.r),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 40.h),

                            Image.asset(
                              'assets/images/img_8.png',
                              width: 185.w,
                              height: 180.h,
                            ),

                            SizedBox(height: 25.h),

                            Text(
                              "Поздравляем!",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffFEA328),
                              ),
                            ),

                            SizedBox(height: 15.h),

                            Text(
                              "Ваш аккаунт готов к использованию. \nЧерез несколько секунд вы будете \nперенаправлены на главную страницу.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                height: 1.5.h,
                              ),
                            ),

                            SizedBox(height: 30.h),

                            SpinKitCircle(color: Color(0xffFEA328)),
                          ],
                        ),
                      ),
                    );
                  },
                );
                await Future.delayed(Duration(seconds: 1));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationPage(listImage: widget.listImage,)),
                );
              },
              child: Container(
                width: 358.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  gradient: LinearGradient(
                    colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                  ),
                ),
                child: Center(
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
    );
  }
}
