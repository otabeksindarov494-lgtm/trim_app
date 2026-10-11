import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/profile/action_page.dart';

import '../bloc/model/subscription_model.dart';

class ImageList {
  final String image;
  final String title;
  final String subTitle;
  final String sum;

  ImageList({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.sum,
  });
}

final List<ImageList> imageList = [
  ImageList(
    image: 'assets/images/img_56.png',
    title: 'Стрижка & Укладка',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
  ImageList(
    image: 'assets/images/img_57.png',
    title: 'Beauty Make Up',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
  ImageList(
    image: 'assets/images/img_58.png',
    title: 'Стрижка & Покраска',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
  ImageList(
    image: 'assets/images/img_59.png',
    title: 'Стрижка & Бритье',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
];

class ActionsWidget extends StatefulWidget {
  const ActionsWidget({super.key, required this.widgets});

  final Subscriptions widgets;

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Наши сеты',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActionPage(action: widget.widgets),
                    ),
                  );
                },
                child: Text(
                  'Все',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFD9203),
                  ),
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
        GridView.builder(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.67,
          ),
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            final listImage = imageList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(listImage.image, width: 178.w, height: 178.h),
                SizedBox(height: 10.h),
                Text(
                  listImage.title,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2.h),
                Text(
                  overflow: TextOverflow.ellipsis,

                  listImage.subTitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff616161),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  overflow: TextOverflow.ellipsis,
                  listImage.sum,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFD9203),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
