import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trim_app/features/auth/presentation/pages/authorization_page.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/theme/app_theme.dart';

import '../../../../widgets/common/glass.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key, required this.listImage});

  final List<ListImage> listImage;

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final phoneMask = MaskTextInputFormatter(
    mask: '## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> register() async {
    final phone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final password = passwordController.text.trim();

    if (phone.length != 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите правильный номер телефона'),
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Пароль должен содержать минимум 6 символов',
          ),
        ),
      );
      return;
    }

    final fullPhone = '+998$phone';

    setState(() {
      isLoading = true;
    });

    try {
      final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '$phone@trim.app',
        password: password,
      );

      print('AUTH USER ID: ${response.user?.uid}');

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      showOtpBottomSheet(fullPhone);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? e.toString()),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void showOtpBottomSheet(String phone) {
    otpController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return Container(
          width: 428.w,
          height: 358.h,
          decoration: BoxDecoration(
            color: context.theme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),

              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.theme.border,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                'Код подтверждения',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'bold',
                  color: context.theme.textPrimary,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                'Введите 4-значный код подтверждения\nиз отправленного SMS.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: context.theme.textSecondary,
                ),
              ),

              SizedBox(height: 20.h),

              Pinput(
                controller: otpController,
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
                    color: const Color(0xffffab38).withOpacity(0.1),
                    border: Border.all(
                      color: const Color(0xffffab38),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              GestureDetector(
                onTap: () async {
                  await verifyOtp(
                    phone,
                    bottomSheetContext,
                  );
                },
                child: Container(
                  width: 358.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFFAB38),
                        Color(0xffFB9400),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Отправить',
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
        );
      },
    );
  }

  Future<void> verifyOtp(
      String phone,
      BuildContext bottomSheetContext,
      ) async {
    final otp = otpController.text.trim();

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите 4-значный код'),
        ),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('User topilmadi');
      }

      await FirebaseFirestore.instance.collection('profiles').doc(user.uid).set(
        {
          'id': user.uid,
          'phone': phone,
        },
        SetOptions(merge: true),
      );

      if (!mounted) return;

      Navigator.pop(bottomSheetContext);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AuthorizationPage(
            listImage: widget.listImage,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? e.toString()),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
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
        GlassContainer(
          width: 380.w,
          height: 60.h,
            borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: TextField(
              controller: phoneController,
              focusNode: searchFocus,
              keyboardType: TextInputType.number,
              inputFormatters: [phoneMask],
              style: TextStyle(color: context.theme.textPrimary, fontSize: 16.sp),
              decoration: InputDecoration(
                fillColor: Colors.transparent,
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
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: context.theme.textPrimary,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular',
                    ),
                  ),
                ),
                hintText: "",
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
                color: context.theme.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        GlassContainer(
          width: 380.w,
          height: 60.h,
            borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: TextField(
                controller: passwordController,
                focusNode: searchFocus,
                style: TextStyle(
                  color: context.theme.textPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
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
                    fontFamily: 'regular',
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            SizedBox(width: 16.h),
            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Image.asset(
                  'assets/images/img_6.png', width: 24.w, height: 24.h),
            ),
            SizedBox(width: 10.w),
            Text(
              'Вы соглашаетесь с нашими условиями, политикой \nиспользования данных и политикой использования \nфайлов cookie.',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'regular',
                color: context.theme.textSecondary,
              ),
            )
          ],
        ),
        SizedBox(height: 22.h),
        GestureDetector(
          onTap: isLoading ? null : register,
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
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
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
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    otpController.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}
