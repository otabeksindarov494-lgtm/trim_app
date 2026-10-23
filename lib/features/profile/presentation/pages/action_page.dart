import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/profile/presentation/pages/show_action_page.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:trim_app/theme/app_theme.dart';

class ListImage {
  final String image;
  final String title;
  final String subTitle;
  final String sum;

  ListImage({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.sum,
  });
}

final List<ListImage> imageList = [
  ListImage(
    image: 'assets/images/img_56.png',
    title: 'Стрижка & Укладка',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
  ListImage(
    image: 'assets/images/img_57.png',
    title: 'Beauty Make Up',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
  ListImage(
    image: 'assets/images/img_58.png',
    title: 'Стрижка & Покраска',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
  ListImage(
    image: 'assets/images/img_59.png',
    title: 'Стрижка & Бритье',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
];

class ActionPage extends StatefulWidget {
  const ActionPage({super.key, required this.action});

  final Subscriptions action;

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
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
                    color: context.theme.textPrimary,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Наши акции',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: Image.asset(
                    'assets/images/img_30.png',
                    width: 28.w,
                    height: 28.h,
                    color: context.theme.textPrimary,
                  ),
                ),
              ],
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
                final listImages = imageList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowActionPage(
                          imageList: listImages,
                          subscriptions: widget.action,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(listImages.image, width: 178.w, height: 178.h),
                      SizedBox(height: 10.h),
                      Text(
                        listImages.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: context.theme.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        listImages.subTitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: context.theme.textSecondary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        listImages.sum,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffFD9203),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
