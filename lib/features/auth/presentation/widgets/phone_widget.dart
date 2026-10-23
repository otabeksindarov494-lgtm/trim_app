import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trim_app/features/home/presentation/widgets/navigation_page.dart';
import 'package:trim_app/features/auth/presentation/pages/password_page.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/theme/app_theme.dart';

class PhoneWidget extends StatefulWidget {
  const PhoneWidget({super.key, required this.listImage});

  final List<ListImage> listImage;

  @override
  State<PhoneWidget> createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.length != 12) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Введите номер телефона')));
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
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '$phone@trim.app',
        password: password,
      );

      if (response.user != null) {
        if (!mounted) return;

        Navigator.pushReplacement(
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

  final phoneMask = MaskTextInputFormatter(
    mask: '## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Введите номер',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'semibold',
                color: context.theme.textPrimary,
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
            color: context.theme.inputBackground,
            border: Border.all(color: context.theme.border),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [phoneMask],
                style: TextStyle(color: context.theme.textPrimary, fontSize: 16.sp),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  prefixIconConstraints: const BoxConstraints(minWidth: 0),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 8.w),
                    child: Text(
                      "+998 |",
                      style: TextStyle(fontSize: 16.sp, color: context.theme.textPrimary),
                    ),
                  ),
                  hintText: "",
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
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'semibold',
                color: context.theme.textPrimary,
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
            color: context.theme.inputBackground,
            border: Border.all(color: context.theme.border),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: '⚫',
                style: TextStyle(
                  color: context.theme.textPrimary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: 'Пароль',
                  hintStyle: TextStyle(
                    color: context.theme.textSecondary,
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
                fontFamily: 'regular',
                color: context.theme.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 180.h),
        GestureDetector(
          onTap: isLoading ? null : login,
          child: Container(
            width: 358.w,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              gradient: const LinearGradient(
                colors: [Color(0xffFFAB38), Color(0xffFB9400)],
              ),
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Войти',
                      style: TextStyle(
                        fontSize: 16,
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
                color: const Color(0xffFEA325),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          width: 358.w,
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: context.theme.inputBackground,
            border: Border.all(color: context.theme.border),
          ),
          child: Center(
            child: Text(
              'Регистрация',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: context.theme.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
