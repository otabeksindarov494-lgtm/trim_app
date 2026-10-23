import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class Subscriptions {
  final String image;
  final String title;
  final String podcastCount;
  final String order;
  bool isSelected;

  Subscriptions({
    required this.image,
    required this.title,
    required this.podcastCount,
    required this.order,
    this.isSelected = false,
  });
}

final List<Subscriptions> subscriptions = [
  Subscriptions(
    image: "assets/images/img_23.png",
    title: 'Uncle Chill',
    podcastCount: 'ТЦ Зарафшан, Матбуотчилар, 17',
    order: 'Стрижка Фейд, Коротое бритье, Алое Вера шампунь',
  ),
  Subscriptions(
    image: "assets/images/img_27.png",
    title: 'Genesis',
    podcastCount: 'Массив Буюк Ипак Йули, 45а',
    order: 'Стрижка короткая, Универсальное бритье, Натуральный шампунь',
  ),
];

class CancelPage extends StatefulWidget {
  const CancelPage({super.key});

  @override
  State<CancelPage> createState() => _CancelPageState();
}

class _CancelPageState extends State<CancelPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: appNavBarHeight(context) + 5.h),
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final orders = subscriptions[index];
          return GlassContainer(
            width: 380.w,
            height: 291.h,
            margin: EdgeInsets.only(bottom: 24.h),
            borderRadius: BorderRadius.circular(24.r),
            padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '22 Дек 2023 - 10:13',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: context.theme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: Container(
                          width: 81.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              'Отменен',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Divider(height: 1.h, thickness: 2, color: context.theme.border),
                  SizedBox(height: 24.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(orders.image, width: 100.w, height: 100.h),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orders.title,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: context.theme.textPrimary,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              orders.podcastCount,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: context.theme.textSecondary,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Заказ:',
                                    style: TextStyle(color: context.theme.textSecondary),
                                  ),
                                  TextSpan(
                                    text: orders.order,
                                    style: const TextStyle(color: Color(0xffFD9301)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Divider(height: 1.h, thickness: 2, color: context.theme.border),
                  SizedBox(height: 16.h),
                  Container(
                    width: 332.w,
                    height: 39.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.r),
                      border: Border.all(
                        color: const Color(0xFFFD9301),
                        width: 2.2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Открыть чек',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFD9301),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          );
        },
      ),
    );
  }

  double appNavBarHeight(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const designAllowance = 20.0;
    final extraInset = (bottomInset - designAllowance).clamp(
      0.0,
      double.infinity,
    );
    return 100.h + extraInset;
  }
}
