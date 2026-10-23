import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/home/presentation/pages/home_menu.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class ShowCheckPage extends StatefulWidget {
  const ShowCheckPage({super.key, required this.showCheck, required this.listImage});

  final Subscriptions showCheck;
  final List<ListImage> listImage;

  @override
  State<ShowCheckPage> createState() => _ShowCheckPageState();
}

class _ShowCheckPageState extends State<ShowCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 77.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 24.w),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeMenu(listImage: widget.listImage)),
                    );
                  },
                  child: Image.asset(
                    'assets/images/img_5.png',
                    width: 28.w,
                    height: 28.h,
                    color: context.theme.textPrimary,
                  ),
                ),
                SizedBox(width: 24.w),
                Text(
                  'Чек',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.h),
            Center(
              child: Image.asset(
                'assets/images/img_77.png',
                width: 211.w,
                height: 120.h,
              ),
            ),
            SizedBox(height: 24.h),
            GlassContainer(
              width: 380.w,
              height: 344.h,
              borderRadius: BorderRadius.circular(16.r),
              child: Column(
                children: [
                  _checkRow('Барбер/Салон', widget.showCheck.title),
                  _checkRow('Адресс', widget.showCheck.podcastCount),
                  _checkRow('Имя', 'Otabek'),
                  _checkRow('Номер', '+998 99 999-99-99'),
                  _checkRow('Дата заказа', '15 Август 2024'),
                  _checkRow('Время заказа', '11:00'),
                  _checkRow('Исполнитель', 'Ходжиакбар'),
                ],
              ),
            ),
            SizedBox(height: 195.h),
            Container(
              width: 380.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                gradient: const LinearGradient(
                  colors: [Color(0xffFFAB38), Color(0xffFB9400)],
                ),
              ),
              child: const Center(
                child: Text(
                  'Скачать чек',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: context.theme.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.theme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
