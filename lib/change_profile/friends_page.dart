import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      backgroundColor: Colors.white,
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
                  ),
                ),
                SizedBox(width: 20.w),
                Text(
                  'Пригласить друзей',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: Image.asset(
                    'assets/images/img_36.png',
                    width: 24.w,
                    height: 24.h,
                    color: Colors.black,
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
                            SizedBox(width: 16.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listImage.title,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8.h),
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
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 24.w),
                              child: _buildSubscribeButton(listImage, index),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Divider(
                          height: 1.h,
                          thickness: 2,
                          color: Color(0xffEEEEEE),
                          indent: 24,
                          endIndent: 24,
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

  Widget _buildSubscribeButton(ImageList imageList, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          imageList.isEnabled = !imageList.isEnabled;
        });
      },
      child: Container(
        width: 130.w,
        height: 37.h,
        decoration: BoxDecoration(
          color: imageList.isEnabled ? Colors.white : Color(0xffFD9301),
          borderRadius: BorderRadius.circular(150.r),
          border: imageList.isEnabled
              ? Border.all(color: Color(0xffFD9301), width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            imageList.isEnabled ? "Отправлено" : "Пригласить",
            style: TextStyle(
              color: imageList.isEnabled ? Color(0xffFD9301) : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
