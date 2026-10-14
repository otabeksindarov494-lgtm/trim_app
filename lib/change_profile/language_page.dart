import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/l10n/app_localizations.dart';
import 'package:trim_app/l10n/language_cubit.dart';

class LanguageItem {
  final String code;
  final String nameKey;

  const LanguageItem({required this.code, required this.nameKey});
}

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  static const List<LanguageItem> languages = [
    LanguageItem(code: 'uz', nameKey: 'uzbek'),
    LanguageItem(code: 'ru', nameKey: 'russian'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LanguageCubit>().state;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 84.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(width: 20.w),
                Text(
                  context.tr('language_and_region'),
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 33.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                context.tr('suggested'),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];

                  return GestureDetector(
                    onTap: () {
                      context.read<LanguageCubit>().changeLanguage(lang.code);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 28.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.tr(lang.nameKey),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Radio<String>(
                            value: lang.code,
                            groupValue: currentLocale.languageCode,
                            activeColor: const Color(0xffFF9500),
                            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color(0xffFF9500);
                              }
                              return const Color(0xffFF9500);
                            }),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<LanguageCubit>().changeLanguage(value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
