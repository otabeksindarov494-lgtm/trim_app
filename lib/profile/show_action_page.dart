import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/profile/calendar_page.dart';

import '../bloc/model/subscription_model.dart';

class Service {
  final String text;
  bool isEnabled;

  Service({required this.text, this.isEnabled = false});
}

final List<Service> service = [
  Service(text: 'Стрижка'),
  Service(text: 'Прическа'),
  Service(text: 'Укладка'),
  Service(text: 'Покраска'),
  Service(text: 'Бритье усов'),
  Service(text: 'Бритье бороды'),
];

class ShowActionPage extends StatefulWidget {
  const ShowActionPage({
    super.key,
    required this.imageList,
    required this._subscriptions,
  });

  final  ListImage imageList;
  final Subscriptions _subscriptions;

  @override
  State<ShowActionPage> createState() => _ShowActionPageState();
}

class _ShowActionPageState extends State<ShowActionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 77.h, left: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                  widget.imageList.title,
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: Image.asset(
                    'assets/images/img_30.png',
                    width: 28.w,
                    height: 28.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 44.h),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32.r),
                child: Image.asset(
                  widget.imageList.image,
                  width: 380.w,
                  height: 300.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Lorem ipsum dolor sit amet consectetur. Sit a'
              '\npellentesque interdum augue fames ultrices in sem. '
              '\nUltricies tempus faucibus morbi aliquet ut tellus ut. Nulla '
              '\nat consectetur non sed posuere lacinia. Подробнее ...',
            ),

            SizedBox(height: 24.h),
            Row(
              children: [
                Text(
                  'Специальное предложение действует до:',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 9.w),
                Text(
                  '20 Дек 2024',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFD9301),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              'Услуги',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 24.h),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 7.5,
              ),
              itemCount: service.length,
              itemBuilder: (context, index) {
                final services = service[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          services.isEnabled = !services.isEnabled;
                        });
                      },
                      child: Row(
                        children: [
                          services.isEnabled
                              ? Image.asset(
                                  'assets/images/img_7.png',
                                  width: 24.w,
                                  height: 24.h,
                                )
                              : Image.asset(
                                  'assets/images/img_6.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                          SizedBox(width: 10.w),
                          Text(services.text),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 65.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarPage(
                      calendar: widget._subscriptions,
                      imageList: imageList,
                    ),
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
    );
  }
}
