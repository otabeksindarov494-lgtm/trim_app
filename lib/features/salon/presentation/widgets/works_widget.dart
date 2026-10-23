import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/theme/app_theme.dart';

class ImageList {
  final String image;

  ImageList({
    required this.image,
  });
}

final List<ImageList> imageList = [
  ImageList(image: 'assets/images/img_56.png'),
  ImageList(image: 'assets/images/img_57.png'),
  ImageList(image: 'assets/images/img_58.png'),
  ImageList(image: 'assets/images/img_59.png'),
  ImageList(image: 'assets/images/img_60.png'),
  ImageList(image: 'assets/images/img_61.png'),
  ImageList(image: 'assets/images/img_62.png'),
  ImageList(image: 'assets/images/img_63.png'),
  ImageList(image: 'assets/images/img_64.png'),
];

class worksWidget extends StatelessWidget {
  const worksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Наши работы',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: context.theme.textPrimary,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: const Text(
                'Все',
                style: TextStyle(
                  fontSize: 14,
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
          color: context.theme.border,
        ),
        GridView.builder(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 24.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.95,
          ),
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            final listImage = imageList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(listImage.image, width: 120.w, height: 120.h),
              ],
            );
          },
        ),
      ],
    );
  }
}
