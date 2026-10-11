import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/profile/calendar_page.dart';
import 'package:trim_app/profile/message_ai_page.dart';
import 'package:trim_app/profile/message_page.dart';
import 'package:trim_app/profile/review_widget.dart';
import 'package:trim_app/profile/servise_widget.dart';
import 'package:trim_app/profile/works_widget.dart';
import '../bloc/model/subscription_model.dart';
import 'about_widget.dart';
import 'actions_widget.dart';

class Detail {
  final String id;
  final String image;
  final String title;
  final String podcastCount;

  Detail({
    required this.image,
    required this.title,
    required this.podcastCount,
    required this.id,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      image: json['photo_url'] ?? '',
      title: json['name'] ?? '',
      podcastCount: json['role'] ?? '',
    );
  }
}

@RoutePage()
class ProfilePage extends StatefulWidget {
  final List<ListImage> listImage;
  final Subscriptions profile;

  const ProfilePage({
    super.key,
    required this.profile,
    required this.listImage,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> interests = [
    'О нас',
    'Услуги',
    'Акции',
    'Работы',
    'Отзывы',
  ];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 100.h),
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        widget.profile.image,
                        width: 428.w,
                        height: 256.h,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      Positioned(
                        top: 78.h,
                        left: 24.w,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/img_5.png',
                            width: 28.w,
                            height: 28.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 78.h,
                        right: 24.w,
                        child: Image.asset(
                          'assets/images/img_26.png',
                          width: 28.w,
                          height: 28.h,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      SizedBox(width: 24.w),
                      Text(
                        widget.profile.title,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 24.w),
                        child: Container(
                          width: 107.w,
                          height: 37.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.r),
                            color: Color(0xffFD9301),
                          ),
                          child: Center(
                            child: Text(
                              'Открыто',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      SizedBox(width: 24.w),
                      Image.asset(
                        'assets/images/img_24.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        widget.profile.podcastCount,
                        style: TextStyle(color: Color(0xff616161)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 24.w),
                      Image.asset(
                        'assets/images/img_25.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        '4.8 (1.285 отзывов)',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff616161),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 27.h),
                  Row(
                    children: [
                      SizedBox(width: 18.w),
                      Image.asset(
                        'assets/images/img_38.png',
                        width: 76.w,
                        height: 87.h,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageAiPage(
                                salonId: widget.profile.id,
                                salonTitle: widget.profile.title,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/img_40.png',
                          width: 76.w,
                          height: 87.h,
                        ),
                      ),

                      Image.asset(
                        'assets/images/img_39.png',
                        width: 76.w,
                        height: 87.h,
                      ),

                      Image.asset(
                        'assets/images/img_41.png',
                        width: 76.w,
                        height: 87.h,
                      ),

                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Container(
                                width: 428.w,
                                height: 220.h,
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
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    Text(
                                      "Поделиться",
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    Divider(
                                      height: 1.h,
                                      thickness: 2,
                                      endIndent: 24.w,
                                      indent: 24.w,
                                      color: Color(0xffEEEEEE),
                                    ),
                                    SizedBox(height: 24.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/img_95.png',
                                          width: 48.w,
                                          height: 48.h,
                                        ),
                                        SizedBox(width: 24.w),
                                        Image.asset(
                                          'assets/images/img_96.png',
                                          width: 48.w,
                                          height: 48.h,
                                        ),
                                        SizedBox(width: 24.w),
                                        Image.asset(
                                          'assets/images/img_97.png',
                                          width: 48.w,
                                          height: 48.h,
                                        ),
                                        SizedBox(width: 24.w),
                                        Image.asset(
                                          'assets/images/img_98.png',
                                          width: 48.w,
                                          height: 48.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Image.asset(
                          'assets/images/img_43.png',
                          width: 76.w,
                          height: 87.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Divider(
                    height: 1.h,
                    thickness: 2,
                    indent: 24.w,
                    endIndent: 24.w,
                    color: Color(0xffEEEEEE),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Наши мастера',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 95.w),
                      Text(
                        'Все',
                        style: TextStyle(
                          color: Color(0xffFEA328),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 175.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: detail.map((detail) {
                          return Container(
                            width: 122.w,
                            height: 153.h,
                            margin: EdgeInsets.only(left: 24.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              color: Color(0xffFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffE9E9E9),
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15.h),
                                Image.asset(
                                  detail.image,
                                  width: 90.w,
                                  height: 90.h,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  detail.title,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  detail.podcastCount,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
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
                            index,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              if (isSelected == 0) AboutWidget(profile: widget.profile),

              if (isSelected == 1)
                ServicePage(
                  service: widget.profile,
                  listImage: widget.listImage,
                ),

              if (isSelected == 2) ActionsWidget(widgets: widget.profile),
              if (isSelected == 3) worksWidget(),
              if (isSelected == 4) ReviewWidget(),
            ],
          ),
          Positioned(
            left: 0.h,
            right: 0.w,
            bottom: 0.h,
            child: ClipRRect(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CalendarPage(
                              calendar: widget.profile,
                              imageList: widget.listImage,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 358.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient: LinearGradient(
                            colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffFFAB38),
                              blurRadius: 15,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Забронировать',
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryButton(String text, bool selected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = index;
        });
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFD9301) : Colors.white,
          borderRadius: BorderRadius.circular(150.r),
          border: Border.all(color: const Color(0xFFFD9301), width: 2),
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
