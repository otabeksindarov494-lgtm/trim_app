import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    icon: 'assets/images/img_93.png',
    subTitle: 'Договорились!',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Анна',
    icon: 'assets/images/img_93.png',
    subTitle: 'Это отличная новость',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Максим',
    icon: 'assets/images/img_94.png',
    subTitle: 'Я буду через 5 минуты',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Мария',
    icon: 'assets/images/img_94.png',
    subTitle: 'Отличный результат. Спасибо',
  ),
];

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
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
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              SizedBox(width: 5.w),
                              Text(
                                listImage.subTitle,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff616161),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    SizedBox(height: 100,),
                    Container(
                      height: MediaQuery.of(context).size.height * 5,
                      width: 300,
                    ),
                    Column(
                      children: [
                        Image.asset(listImage.icon, width: 24.w, height: 24.h),
                        SizedBox(height: 10.h),
                        Text(
                          '22:00',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff616161),
                          ),
                        ),
                      ],
                    ),
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
