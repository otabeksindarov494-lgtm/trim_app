import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/home_menu.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/profile/my_calendar.dart';
import 'package:trim_app/profile/payment_page.dart';

import '../bloc/model/subscription_model.dart';

class Detail {
  final String id;
  final String image;
  final String title;
  final String podcastCount;
  bool isEnabled;

  Detail({
    required this.image,
    required this.title,
    required this.podcastCount,
    this.isEnabled = false,
    required this.id,
  });
}

final List<Detail> detail = [
  Detail(id: 'master_1', image: "assets/images/img_44.png", title: 'Ходжиакбар', podcastCount: 'Барбер'),
  Detail(id: 'master_2', image: "assets/images/img_42.png", title: 'Светлана', podcastCount: 'Парикмахер'),
  Detail(id: 'master_3', image: "assets/images/img_45.png", title: 'Алли', podcastCount: 'Мастер'),
  Detail(id: 'master_4', image: "assets/images/d067c913ad868d019f92ce267e6de23af3413e5b.png", title: 'Гульнора', podcastCount: 'Визажист'),
];

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.calendar, required this.imageList,});

  final Subscriptions calendar;
  final  List <ListImage> imageList;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final List<String> interests = ['9:00', '10:00', '11:00', '12:00', '13:00'];
  int isSelected = 0;

  // Uchta alohida o'zgaruvchi
  int selectedTimeIndex = -1;    // -1 = hech narsa tanlanmagan
  int selectedMasterIndex = -1;
  DateTime? selectedDate;

  void _onNext() {
    // Validatsiya
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sanani tanlang')),
      );
      return;
    }
    if (selectedTimeIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vaqtni tanlang')),
      );
      return;
    }
    if (selectedMasterIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ustani tanlang')),
      );
      return;
    }

    // Tanlangan ma'lumotlarni PaymentPage'ga uzatamiz
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          cheks: widget.calendar,
          listImage: widget.imageList,
          bookingDate: selectedDate!,
          bookingTime: interests[selectedTimeIndex],
          masterId: detail[selectedMasterIndex].id,
          masterName: detail[selectedMasterIndex].title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 100.h),
            children: [
              Padding(
                padding: EdgeInsets.only(right: 24.w, top: 65.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          'Записаться на прием',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/img_30.png',
                          width: 28.w,
                          height: 28.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h),
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Text(
                        'Выберите дату',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: MyCalendar(
                        onDateSelected: (date) {
                          setState(() => selectedDate = date);
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Выберите время',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 95.w),
                        Text(
                          'Все',
                          style: TextStyle(
                            color: Color(0xffFEA328),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 24.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: interests.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: categoryButton(
                              interests[index],
                              index == selectedTimeIndex,
                              index,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Наши мастера',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 95.w),
                        Text(
                          'Все',
                          style: TextStyle(
                            color: Color(0xffFEA328),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      height: 175.h,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(detail.length, (index) {
                            final master = detail[index];
                            final isMasterSelected =
                                selectedMasterIndex == index;
                            return GestureDetector(
                              onTap: () {
                                  setState(() => selectedMasterIndex = index);
                              },
                              child: Container(
                                width: 122.w,
                                height: 153.h,
                                margin: EdgeInsets.only(left: 24.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color: isMasterSelected
                                        ? Color(0xFFFD9301)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  color: Color(0xffFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffE9E9E9),
                                      blurRadius: 12.r,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15.h),
                                    Image.asset(
                                      master.image,
                                      width: 90.w,
                                      height: 90.h,
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      master.title,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected == 0
                                            ? Color(0xFFFD9301)
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      master.podcastCount,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                      onTap: _onNext,
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
                                  offset: Offset(0, 4)
                              )
                            ]
                        ),
                        child: Center(
                          child: Text(
                            'Далее',
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

  Widget categoryButton(String text, bool selected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedTimeIndex = index);
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFD9301) : Colors.white,
          borderRadius: BorderRadius.circular(150.r),
          border: Border.all(color: const Color(0xFFFD9301), width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFFFD9301),
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
