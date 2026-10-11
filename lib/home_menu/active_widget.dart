import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class ActiveWidget extends StatefulWidget {
  const ActiveWidget({super.key});

  @override
  State<ActiveWidget> createState() => _ActiveWidgetState();
}

class _ActiveWidgetState extends State<ActiveWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: appNavBarHeight(context) + 5.h),
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final orders = subscriptions[index];
          return Container(
            width: 380.w,
            height: 291.h,
            margin: EdgeInsets.only(bottom: 24.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xffE9E9E9),
                  blurRadius: 24.r,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
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
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Напомнить',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Transform.translate(
                        offset: Offset(0, -8),
                        child: CupertinoSwitch(
                          activeTrackColor: Color(0xffF49803),
                          value: orders.isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              orders.isSelected = value ?? false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Divider(height: 1.h, thickness: 2, color: Color(0xffEEEEEE)),
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
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              orders.podcastCount,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
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
                                    style: TextStyle(color: Color(0xff616161)),
                                  ),
                                  TextSpan(
                                    text: orders.order,
                                    style: TextStyle(color: Color(0xffFD9301)),
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
                  Divider(height: 1.h, thickness: 2, color: Color(0xffEEEEEE)),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: appNavBarHeight(context) + 5.h),
                                child: Container(
                                  width: 428.w,
                                  height: 358.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                      SizedBox(height: 30.h),
                                      Text(
                                        "Отмена бронирование",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      Divider(
                                        height: 1.h,
                                        thickness: 2,
                                        endIndent: 24,
                                        indent: 24,
                                        color: Color(0xffEEEEEE),
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        'Вы уверены что хотите \nотменить бронирование?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        'При отмене бронирования ваш рейтинг \nпользователя снизится.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 178.w,
                                              height: 58.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                  100.r,
                                                ),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(
                                                      0xffFFAB38,
                                                    ).withOpacity(0.1),
                                                    Color(
                                                      0xffFB9400,
                                                    ).withOpacity(0.1),
                                                  ],
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Назад',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffFEA328),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Container(
                                              width: 178.w,
                                              height: 58.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                  100.r,
                                                ),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xffFFAB38,),
                                                    Color(0xffFB9400,),
                                                  ],
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Да отменить',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 155.w,
                          height: 39.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.r),
                            border: Border.all(
                              color: Color(0xFFFD9301),
                              width: 2.2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Отменить',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFD9301),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 155.w,
                        height: 39.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.r),
                          color: Color(0xFFFD9301),
                        ),
                        child: Center(
                          child: Text(
                            'Открыть чек',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
