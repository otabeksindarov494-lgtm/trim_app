import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/theme/app_theme.dart';

class ImageList {
  final String image;
  final String title;
  final String subTitle;
  bool isEnabled;

  ImageList({
    required this.image,
    required this.title,
    required this.subTitle,
    this.isEnabled = false,
  });
}

final List<ImageList> imageList = [
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Мария',
    subTitle: '+998 99 999-99-99',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Анна',
    subTitle: '+998 99 999-99-99',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Максим',
    subTitle: '+998 99 999-99-99',
  ),
  ImageList(
    image: 'assets/images/img_65.png',
    title: 'Мария',
    subTitle: '+998 99 999-99-99',
  ),
];

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 84.h),
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
                SizedBox(width: 20.w),
                Text(
                  'Пригласить друзей',
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
                    'assets/images/img_36.png',
                    width: 24.w,
                    height: 24.h,
                    color: context.theme.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 57.h),
            Expanded(
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
                            SizedBox(width: 24.w),
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
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 24.w),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    listImage.isEnabled = !listImage.isEnabled;
                                  });
                                },
                                child: Container(
                                  width: 100.w,
                                  height: 38.h,
                                  decoration: BoxDecoration(
                                    color: listImage.isEnabled
                                        ? context.theme.surface
                                        : const Color(0xffFD9301),
                                    borderRadius: BorderRadius.circular(100.r),
                                    border: Border.all(
                                      color: const Color(0xffFD9301),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      listImage.isEnabled
                                          ? 'Отправлено'
                                          : 'Пригласить',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: listImage.isEnabled
                                            ? const Color(0xffFD9301)
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
