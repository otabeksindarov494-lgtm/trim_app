import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/booking/presentation/pages/calendar_page.dart';
import 'package:trim_app/features/chat/presentation/pages/message_ai_page.dart';
import 'package:trim_app/features/profile/presentation/widgets/review_widget.dart';
import 'package:trim_app/features/salon/presentation/widgets/servise_widget.dart';
import 'package:trim_app/features/salon/presentation/widgets/works_widget.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:trim_app/features/salon/presentation/widgets/about_widget.dart';
import 'package:trim_app/features/profile/presentation/widgets/actions_widget.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

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

  Widget _buildProfileImage(String imagePath, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/img_23.png',
          width: width,
          height: height,
          fit: fit,
        ),
      );
    } else if (imagePath.isNotEmpty) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/img_23.png',
          width: width,
          height: height,
          fit: fit,
        ),
      );
    } else {
      return Image.asset(
        'assets/images/img_23.png',
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 100.h),
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      _buildProfileImage(
                        widget.profile.image,
                        width: 428.w,
                        height: 256.h,
                        fit: BoxFit.cover,
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
                          color: context.theme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 24.w),
                        child: Container(
                          width: 107.w,
                          height: 37.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.r),
                            color: const Color(0xffFD9301),
                          ),
                          child: const Center(
                            child: Text(
                              'Открыто',
                              style: TextStyle(
                                fontSize: 14,
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
                        color: context.theme.textSecondary,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        widget.profile.podcastCount,
                        style: TextStyle(color: context.theme.textSecondary),
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
                          color: context.theme.textSecondary,
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
                              return GlassContainer(
                                width: 428.w,
                                height: 220.h,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(32.r),
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
                                        color: context.theme.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    Divider(
                                      height: 1.h,
                                      thickness: 2,
                                      endIndent: 24.w,
                                      indent: 24.w,
                                      color: context.theme.border,
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
                    color: context.theme.border,
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
                          color: context.theme.textPrimary,
                        ),
                      ),
                      SizedBox(width: 95.w),
                      Text(
                        'Все',
                        style: TextStyle(
                          color: const Color(0xffFEA328),
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
                        children: detail.map((master) {
                          return GlassContainer(
                            width: 122.w,
                            height: 153.h,
                            margin: EdgeInsets.only(left: 24.w),
                            borderRadius: BorderRadius.circular(24.r),
                            child: Column(
                              children: [
                                SizedBox(height: 15.h),
                                Image.asset(
                                  master.image,
                                  width: 90.w,
                                  height: 90.h,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  master.title,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: context.theme.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  master.podcastCount,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: context.theme.textSecondary,
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
              if (isSelected == 3) const worksWidget(),
              if (isSelected == 4) const ReviewWidget(),
            ],
          ),
          Positioned(
            left: 0.w,
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
                          gradient: const LinearGradient(
                            colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xffFFAB38).withOpacity(0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
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
          color: selected ? const Color(0xFFFD9301) : context.theme.surface,
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
