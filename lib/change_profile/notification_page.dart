import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Podcast {
  final String text;
  bool isEnabled;

  Podcast({required this.text, this.isEnabled = false});
}

final List<Podcast> podcast = [
  Podcast(text: 'Общие уведомлене'),
  Podcast(text: 'Звук'),
  Podcast(text: 'Вибрация'),
  Podcast(text: 'Специальное предложения'),
  Podcast(text: 'Промо Акции'),
  Podcast(text: 'Оплата'),
  Podcast(text: 'Обновление приложение'),
];

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
                SizedBox(width: 28.w),
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
                  'Уведомление',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(height: 34.h),
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 0.h),
                itemCount: podcast.length,
                separatorBuilder: (_, __) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final podcasts = podcast[index];
                  return Row(
                    children: [
                      Text(
                        podcasts.text,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 24.w),
                        child: CupertinoSwitch(
                          activeTrackColor: Color(0xffF49803),
                          value: podcasts.isEnabled,
                          onChanged: (bool? value) {
                            setState(() {
                              podcasts.isEnabled = value ?? false;
                            });
                          },
                        ),
                      ),
                    ],
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
