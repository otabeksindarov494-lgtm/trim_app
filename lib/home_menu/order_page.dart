import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/home_menu/active_widget.dart';
import 'package:trim_app/home_menu/cancel_page.dart';
import 'package:trim_app/home_menu/complete_widget.dart';


class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<String> interests = ['Активно', 'Завершено', 'Отменено'];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 68.h, left: 24.w, right: 24.w),
        child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/images/img_9.png', width: 34.w, height: 34.h),
              SizedBox(width: 16.w),
              Text(
                'Мои заказы',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              Spacer(),
              Image.asset(
                'assets/images/img_36.png',
                width: 24.w,
                height: 24.h,
                color: Colors.black,
              ),
              SizedBox(width: 15.w),
              Image.asset('assets/images/img_30.png', width: 28.w, height: 28.h),
            ],
          ),
          SizedBox(height: 24.h),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: interests.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: categoryButton(
                    interests[index],
                    index == isSelected,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 24.h),
          if(isSelected == 0)
            ActiveWidget(),
          if(isSelected == 1)
            CompleteWidget(),
          if(isSelected == 2)
            CancelPage(),
        ],
                  ),
      ),
    );
  }

  Widget categoryButton(String text, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = interests.indexOf(text);
        });
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFD9301) : Colors.white,
          borderRadius: BorderRadius.circular(150.r),
          border: Border.all(color: const Color(0xFFFD9301), width: 2.2),
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
