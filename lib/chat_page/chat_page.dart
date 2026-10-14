import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/chat_page/call_page.dart';
import 'package:trim_app/chat_page/chat_widget.dart';
import 'package:trim_app/l10n/app_localizations.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> interestKeys = ['chat', 'calls'];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 84.h, left: 24.w, right: 24.w),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/img_9.png', width: 34.w, height: 34.h),
                SizedBox(width: 16.w),
                Text(
                  context.tr('chat'),
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
            Divider(height: 1.h, thickness: 2, color: const Color(0xffEEEEEE)),
            SizedBox(height: 24.h),
            if (isSelected == 0) CallPage(),
            if (isSelected == 1) ChatWidget(),
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
        width: 170.w,
        height: 38.h,
        margin: EdgeInsets.only(left: 5.w),
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
