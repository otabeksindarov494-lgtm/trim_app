import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/home/presentation/widgets/active_widget.dart';
import 'package:trim_app/features/booking/presentation/pages/cancel_page.dart';
import 'package:trim_app/features/home/presentation/widgets/complete_widget.dart';
import 'package:trim_app/core/l10n/app_localizations.dart';
import 'package:trim_app/theme/app_theme.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<String> interestKeys = ['active', 'completed', 'cancelled'];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 68.h, left: 24.w, right: 24.w),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/img_9.png', width: 34.w, height: 34.h),
                SizedBox(width: 16.w),
                Text(
                  context.tr('my_orders'),
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.theme.textPrimary),
                ),
                const Spacer(),
                Image.asset(
                  'assets/images/img_36.png',
                  width: 24.w,
                  height: 24.h,
                  color: context.theme.textPrimary,
                ),
                SizedBox(width: 15.w),
                Image.asset('assets/images/img_30.png', width: 28.w, height: 28.h, color: context.theme.textPrimary),
              ],
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: interestKeys.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: categoryButton(
                      context.tr(interestKeys[index]),
                      index == isSelected,
                      index,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            if (isSelected == 0) const ActiveWidget(),
            if (isSelected == 1) const CompleteWidget(),
            if (isSelected == 2) const CancelPage(),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String text, bool selected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = index;
        });
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFD9301) : context.theme.surface,
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
