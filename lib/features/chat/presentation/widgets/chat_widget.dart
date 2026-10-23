import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/theme/app_theme.dart';

class ImageList {
  final String image;
  final String title;
  final String icon;
  final String subTitle;
  bool isEnabled;

  ImageList({
    required this.image,
    required this.title,
    required this.icon,
    this.isEnabled = false,
    required this.subTitle,
  });
}

final List<ImageList> imageList = [
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Мария',
    icon: 'assets/images/img_90.png',
    subTitle: 'Исходящий | 10 Авг 2024',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Анна',
    icon: 'assets/images/img_91.png',
    subTitle: 'Входящий | 10 Авг 2024',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Максим',
    icon: 'assets/images/img_92.png',
    subTitle: 'Пропушеный | 10 Авг 2024',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Мария',
    icon: 'assets/images/img_90.png',
    subTitle: 'Исходящий | 10 Авг 2024',
  ),
];

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          final listImage = imageList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 24.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(listImage.image, width: 60.w, height: 60.h),
                    Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listImage.title,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: context.theme.textPrimary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Image.asset(
                                listImage.icon,
                                width: 16.w,
                                height: 16.h,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                listImage.subTitle,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: context.theme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Image.asset('assets/images/img_89.png', width: 24.w, height: 24.h),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
