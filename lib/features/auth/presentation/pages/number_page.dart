import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:trim_app/features/auth/presentation/pages/confirm_code_page.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/theme/app_theme.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({super.key, required this.listImage});
  final List<ListImage> listImage;

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  final TextEditingController _amountController = TextEditingController();

  final phoneMask = MaskTextInputFormatter(
    mask: '## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Введите номер телефон',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'semibold',
                color: context.theme.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          width: 380.w,
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: context.theme.inputBackground,
            border: Border.all(color: context.theme.border),
          ),
          child: Center(
            child: TextField(
              controller: _amountController,
              style: TextStyle(color: context.theme.textPrimary, fontSize: 16.sp),
              keyboardType: TextInputType.number,
              inputFormatters: [phoneMask],
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                prefixIconConstraints: const BoxConstraints(minWidth: 0),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 8.w),
                  child: Text(
                    "+998 |",
                    style: TextStyle(fontSize: 16.sp, color: context.theme.textSecondary),
                  ),
                ),
                hintText: "",
              ),
            ),
          ),
        ),
        SizedBox(height: 150.h),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmCodePage(
                  amount: _amountController.text,
                  listImage: widget.listImage,
                ),
              ),
            );
          },
          child: Container(
            width: 358.w,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              gradient: const LinearGradient(
                colors: [Color(0xffFFAB38), Color(0xffFB9400)],
              ),
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
    );
  }
}
