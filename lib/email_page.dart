import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:trim_app/authorization/authorization_page.dart';
import 'package:trim_app/authorization/create_profile.dart';
import 'package:trim_app/home_menu/navigation_page.dart';
import 'package:trim_app/profile/action_page.dart';

import 'auth_bloc/auth_bloc.dart';
import 'auth_bloc/auth_event.dart';
import 'auth_bloc/auth_state.dart';
import 'home_page.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key, required this.listImage});

  final List<ListImage> listImage;

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('To\'g\'ri email kiriting')));
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Parol kamida 6 belgidan iborat bo\'lsin'),
        ),
      );
      return;
    }

    // Event yuborish — Bloc qolganini bajaradi
    context.read<AuthBloc>().add(
      EmailSignUpRequested(email: email, password: password),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CreateProfilePage(
                profileId: state.user.id,
                email: emailController.text.trim(),
                listImage: widget.listImage,
              ),
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Column(
          children: [
            Row(
              children: [
                SizedBox(width: 24.w),
                Text(
                  'Введите пароль',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'regular',
                  ),
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
                  'Создайте пароль',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'semibold',
                  ),
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
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Image.asset(
                    'assets/images/img_6.png',
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Вы соглашаетесь с нашими условиями, политикой \nиспользования данных и политикой использования \nфайлов cookie.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'regular',
                    color: Color(0xff677294),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            GestureDetector(
              onTap: isLoading ? null : _onRegisterPressed,
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
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
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
        );
      },
    );
  }
}
