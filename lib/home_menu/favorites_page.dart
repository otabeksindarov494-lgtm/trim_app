import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Subscription {
  final String image;
  final String title;
  final String podcastCount;
  bool isEnabled;

  Subscription({
    required this.image,
    required this.title,
    required this.podcastCount,
    this.isEnabled = false,
  });
}

final List<Subscription> subscriptions = [
  Subscription(
    image: "assets/images/img_23.png",
    title: 'Uncle Chill',
    podcastCount: 'ТЦ Зарафшан, Матбуотчилар, 17',
  ),
  Subscription(
    image: "assets/images/img_27.png",
    title: 'Genesis',
    podcastCount: 'Массив Буюк Ипак Йули, 45а',
  ),
  Subscription(
    image: "assets/images/img_28.png",
    title: 'Santander',
    podcastCount: 'Улица Фурката, 2а',
  ),
];

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<String> interests = ['Все', 'Стрижки', 'Макияж', 'Маникюр'];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 77.h),
        child: Column(
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
                SizedBox(width: 16.w),
                Text(
                  'Избранное',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 150.w),
                Image.asset('assets/images/img_30.png', width: 28.w, height: 28.h),
              ],
            ),
            SizedBox(height: 33.h),
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: interests.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: categoryButton(
                      interests[index],
                      index == isSelected,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            Column(
              children: subscriptions.map((subscription) {
                return Container(
                  margin: EdgeInsets.only(bottom: 24.h),
                  width: 380.w,
                  height: 110.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffE9E9E9),
                        blurRadius: 24.r,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 15.h),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            subscription.image,
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    subscription.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: 24.w),
                                    child: Image.asset(
                                      'assets/images/img_29.png',
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                subscription.podcastCount,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff616161),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.w),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/img_24.png',
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          '1.2 km',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 25.w),
                                  Image.asset(
                                    'assets/images/img_25.png',
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '4.2',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String text, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = interests.indexOf(text);
        });
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: selected ? Color(0xFFFD9301) : Colors.white,
          borderRadius: BorderRadius.circular(150.r),
          border: Border.all(color: Color(0xFFFD9301), width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFFFD9301),
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
