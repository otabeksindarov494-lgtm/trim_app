import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageList {
  final String image;
  final String title;
  final String subTitle;
  final String like;
  bool isEnabled;

  ImageList({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.like,
    this.isEnabled = false,
  });
}

final List<ImageList> imageList = [
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Мария',
    subTitle:
        'Здесь работают очень дружелюбные и \nпрофессиональные люди, мне очень понравилось.',
    like: '982',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Анна',
    subTitle: 'Я впервые пробую этот сервис, но результаты меня \nпорадовали!',
    like: '123',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Максим',
    subTitle: 'Я только что узнала, что этот салон находится рядом с моим домом. Думаю, что буду посещать его чаще!',
    like: '456',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Мария',
    subTitle:
        'Здесь работают очень дружелюбные и \nпрофессиональные люди, мне очень понравилось.',
    like: '982',
  ),
];

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Image.asset('assets/images/img_25.png', width: 24.w, height: 24.h),
            SizedBox(width: 16),
            Text(
              '4.8 (1.285 отзывов)',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: Text(
                'Все',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFD9203),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Divider(
          height: 1.h,
          thickness: 2,
          indent: 24,
          endIndent: 24,
          color: Color(0xffEEEEEE),
        ),
        SizedBox(height: 24.h),
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imageList.length,
          itemBuilder: (cotext, index) {
            final listImage = imageList[index];
            return Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(listImage.image, width: 48.w, height: 48.h),
                      SizedBox(width: 16.w),
                      Text(
                        listImage.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 66.w,
                        height: 31.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(112.r),
                          border: Border.all(
                            color: Color(0xffFD9301),
                            width: 1.5.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 13.w),
                            Image.asset(
                              'assets/images/img_25.png',
                              width: 16.w,
                              height: 16.h,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffFD9301),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    listImage.subTitle,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            listImage.isEnabled = !listImage.isEnabled;
                          });
                        },
                        child: listImage.isEnabled
                            ? Image.asset(
                                'assets/images/img_67.png',
                                width: 16.w,
                                height: 16.h,
                              )
                            : Image.asset(
                                'assets/images/img_66.png',
                                width: 16.w,
                                height: 16.h,
                              ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        listImage.like,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '1 месяц назад',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff616161),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
