import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class Subscriptions {
  final String image;
  final String title;
  final String podcastCount;
  bool isEnabled;
  final DateTime date;

  Subscriptions({
    required this.image,
    required this.title,
    required this.podcastCount,
    this.isEnabled = false,
    required this.date,
  });
}

final List<Subscriptions> subscriptions = [
  Subscriptions(
    image: "assets/images/img_34.png",
    title: 'Добавлен карты для оплаты',
    podcastCount: 'Карта оплаты была привязана',
    date: DateTime.now(),
  ),
  Subscriptions(
    image: "assets/images/img_35.png",
    title: 'Аккаунт создана успешно',
    podcastCount: 'ваша учетная запись создана',
    date: DateTime.now(),
  ),
  Subscriptions(
    image: "assets/images/img_33.png",
    title: 'Cпециальное предложение',
    podcastCount: 'сегодня вы получили купон!',
    date: DateTime.now().subtract(
      const Duration(days: 1),
    ),
  ),
];

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String getDateText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final yesterday = today.subtract(
      const Duration(days: 1),
    );
    final currentDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    if (currentDate == today) {
      return 'Сегодня';
    }

    if (currentDate == yesterday) {
      return 'Вчера';
    }

    return '${date.day.toString().padLeft(2, '0')}.'
        '${date.month.toString().padLeft(2, '0')}.'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 77.h),
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
                    color: context.theme.textPrimary,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Уведомление',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: Image.asset(
                    'assets/images/img_30.png',
                    width: 28.w,
                    height: 28.h,
                    color: context.theme.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.h),
            Center(
              child: Column(
                children: subscriptions.asMap().entries.expand((entry) {
                  final index = entry.key;
                  final subscription = entry.value;

                  return [
                    if (index == 0 ||
                        subscriptions[index - 1].date.day != subscription.date.day)
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          bottom: 12.h,
                        ),
                        child: Text(
                          getDateText(subscription.date),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: context.theme.textPrimary,
                          ),
                        ),
                      ),
                    GlassContainer(
                      margin: EdgeInsets.only(bottom: 24.h),
                      width: 380.w,
                      height: 110.h,
                      borderRadius: BorderRadius.circular(24.r),
                      padding: EdgeInsets.only(left: 16.w),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              subscription.image,
                              width: 83.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 31.h),
                                Text(
                                  subscription.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: context.theme.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  subscription.podcastCount,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: context.theme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
