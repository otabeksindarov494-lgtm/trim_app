import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trim_app/password/confirm_code_page.dart';
import 'package:trim_app/profile/action_page.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({super.key, required this.listImage});
  final  List <ListImage> listImage;

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  @override
  void initState() {
    super.initState();

    _amountController.addListener(() {
      final text = _amountController.text.replaceAll(',', '');
      final amount = int.tryParse(text) ?? 0;
    });
  }

  final TextEditingController _amountController = TextEditingController();

  final phoneMask = MaskTextInputFormatter(
    mask: '## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Введите номер',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, fontFamily: 'semibold'),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          width: 380.w,
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Color(0xffFAFAFA),
            border: Border.all(color: Color(0xffEEEEEE)),
          ),
          child: Center(
            child: TextField(
              controller: _amountController,
              style: TextStyle(color: Color(0xff677294)),
              keyboardType: TextInputType.number,
              inputFormatters: [phoneMask],
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIconConstraints: const BoxConstraints(minWidth: 0),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 8.w),
                  child: Text(
                    "+998 |",
                    style: TextStyle(fontSize: 16.sp, color: Color(0xff677294)),
                  ),
                ),
                hintText: "",
              ),
            ),
          ),
        ),
        SizedBox(height: 150.h),
        Container(
          width: 358.w,
          height: 56.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            gradient: LinearGradient(
              colors: [Color(0xffFFAB38), Color(0xffFB9400)],
            ),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ConfirmCodePage(amount: _amountController.text, listImage: widget.listImage,),
                  ),
                );
              },
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
    );
  }
}
