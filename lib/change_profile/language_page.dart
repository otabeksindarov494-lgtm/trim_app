import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Language {
  final String name;
  final bool suggested;

  Language({required this.name, this.suggested = false});
}

final languages = [
  Language(name: "Русский (RUS)", suggested: true),
  Language(name: "English (US)", suggested: true),
  Language(name: "Mandarin"),
  Language(name: "Hindi"),
  Language(name: "Spanish"),
  Language(name: "French"),
  Language(name: "Arabic"),
  Language(name: "Bengali"),
  Language(name: "Russian"),
  Language(name: "Indonesia"),
];

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = "English (US)";

  @override
  Widget build(BuildContext context) {
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
                  'Language & Region',
                  style: TextStyle(fontSize: 24.h, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                itemCount: languages.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 40.h, top: 33.h),
                      child: Text(
                        "Suggested",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }

                  if (index == 3) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(height: 2.h, color: Color(0xffEEEEEE), thickness: 2),
                        SizedBox(height: 24),
                        Text(
                          "Others",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  }

                  final language = index < 3
                      ? languages[index - 1]
                      : languages[index - 2];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 28.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            language.name,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(
                          child: Radio<String>(
                            value: language.name,
                            groupValue: selectedLanguage,
                            activeColor: Color(0xffFF9500),
                            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Color(0xffFF9500);
                              }
                              return Color(0xffFF9500);
                            }),
                            onChanged: (value) {
                              setState(() {
                                selectedLanguage = value!;
                              });
                            },
                          ),
                        ),
                      ],
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