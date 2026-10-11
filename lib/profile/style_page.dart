import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/profile/calendar_page.dart';
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
    image: 'assets/images/img_68.png',
    title: 'Классическая стрижка',
    subTitle: 'Действует до 20 Дек 2024',
    sum: '50 000 UZS',
  ),
  ImageList(
    image: 'assets/images/img_63.png',
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

class StylePage extends StatefulWidget {
  const StylePage({super.key, required this.style, required this._listImage, });
  final  List <ListImage> _listImage;
  final Subscriptions style;

  @override
  State<StylePage> createState() => _StylePageState();
}

class _StylePageState extends State<StylePage> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 65.h),
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
                    SizedBox(width: 16.w),
                    Text(
                      'Стрижки',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 190.w),
                    Image.asset(
                      'assets/images/img_30.png',
                      width: 28.w,
                      height: 28.h,
                    ),
                  ],
                ),
                SizedBox(height: 33.h),
                Row(
                  children: [
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = 0;
                        });
                      },
                      child: Container(
                        width: 184.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            color: isSelected == 0
                                ? Colors.transparent
                                : Color(0xffFFAB38),
                            width: 2,
                          ),
                          color: isSelected == 0
                              ? Color(0xffFFAB38)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Мужское',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: isSelected == 0
                                  ? Colors.white
                                  : Color(0xffFFAB38),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = 1;
                        });
                      },
                      child: Container(
                        width: 184.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            color: isSelected == 1
                                ? Colors.transparent
                                : Color(0xffFFAB38),
                            width: 2,
                          ),
                          color: isSelected == 1
                              ? Color(0xffFFAB38)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Женское',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: isSelected == 1
                                  ? Colors.white
                                  : Color(0xffFFAB38),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                  padding: EdgeInsets.only(left: 24.h, right: 24.w, top: 24.w),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.72,
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
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
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
            ),
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
                            builder: (context) => CalendarPage(calendar: widget.style, imageList: widget._listImage,),
                          ),
                        );
                      },
                      child: Container(
                        width: 358.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient: LinearGradient(
                            colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffFFAB38),
                              blurRadius: 15.r,
                              offset: Offset(0, 4),
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
}
