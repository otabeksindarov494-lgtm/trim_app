import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trim_app/home_menu/navigation_page.dart';
import 'package:trim_app/profile/action_page.dart';
import '../bloc/service/auth_service.dart';
import '../password/password_page.dart';

class EmailWidget extends StatefulWidget {
  const EmailWidget({super.key, required this.listImage});

  final List<ListImage> listImage;

  @override
  State<EmailWidget> createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  bool isEnable = false;

  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите email')));
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите пароль')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final credential = await authService.signInWithEmail(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        print('LOGIN SUCCESS');
        print('User ID: ${credential.user!.uid}');


        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Вход выполнен успешно')));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationPage(listImage: widget.listImage),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? e.toString())));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Введите почту',
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "www.trim@mail.ru",
                  hintStyle: TextStyle(
                    color: Color(0xff677294),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
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
                controller: passwordController,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Пароль',
                  hintStyle: TextStyle(
                    color: Color(0xff677294),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  isEnable = !isEnable;
                });
              },
              child: isEnable
                  ? Image.asset(
                      'assets/images/img_7.png',
                      width: 24.w,
                      height: 24.h,
                    )
                  : Image.asset(
                      'assets/images/img_6.png',
                      width: 24.w,
                      height: 24.h,
                    ),
            ),
            SizedBox(width: 10.w),
            Text(
              'Запомнить пароль',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff677294),
              ),
            ),
          ],
        ),
        SizedBox(height: 180.h),
        GestureDetector(
          onTap: isLoading ? null : handleLogin,
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
              child: isLoading
                  ?  SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Войти',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PasswordPage(listImage: widget.listImage),
                ),
              );
            },
            child: Text(
              'Забыл пароль',
              style: TextStyle(
                color: Color(0xffFEA325),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.sp),
        Container(
          width: 358.w,
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: Color(0xffFAFAFA),
            border: Border.all(color: Color(0xffEEEEEE)),
          ),
          child: Center(
            child: Text(
              'Регистрация',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
