import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:trim_app/theme/app_theme.dart';

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
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: context.theme.textPrimary,
              ),
            ),
            const Spacer(),
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
                child: const Text(
                  'Все',
                  style: TextStyle(
                    fontSize: 14,
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
          color: context.theme.border,
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
            return Column(
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
                  style: const TextStyle(
                    fontSize: 14,
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
