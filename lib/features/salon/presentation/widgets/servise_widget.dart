import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/salon/presentation/pages/style_page.dart';
import 'package:trim_app/features/salon/data/models/subscription_model.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class Services {
  final String image;
  final String text;
  final String subText;

  Services({required this.image, required this.text, required this.subText});
}

final List<Services> services = [
  Services(
    image: 'assets/images/img_48.png',
    text: 'Стрижки',
    subText: '44 Видов',
  ),
  Services(
    image: 'assets/images/img_50.png',
    text: 'Покраска',
    subText: '12 Видов',
  ),
  Services(
    image: 'assets/images/img_51.png',
    text: 'Макияж лица',
    subText: '19 Видов',
  ),
  Services(
    image: 'assets/images/img_49.png',
    text: 'Маникюр',
    subText: '24 Видов',
  ),
  Services(
    image: 'assets/images/img_52.png',
    text: 'Педикюр',
    subText: '18 Видов',
  ),
  Services(
    image: 'assets/images/img_53.png',
    text: 'Бритье',
    subText: '6 Видов',
  ),
  Services(
    image: 'assets/images/img_54.png',
    text: 'Массаж',
    subText: '11 Видов',
  ),
];

@RoutePage()
class ServicePage extends StatefulWidget {
  const ServicePage({
    super.key,
    required this.service,
    required this.listImage,
  });

  final List<ListImage> listImage;
  final Subscriptions service;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.w),
            Text(
              'Наши услуги',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: context.theme.textPrimary,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: const Text(
                'Все',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFD9203),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Divider(
          height: 1.h,
          thickness: 2,
          indent: 24,
          endIndent: 24,
          color: context.theme.border,
        ),
        SizedBox(height: 24.h),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final serviceItem = services[index];
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StylePage(
                          style: widget.service,
                          listImage: widget.listImage,
                        ),
                      ),
                    );
                    break;
                }
              },
              child: GlassContainer(
                margin: EdgeInsets.only(bottom: 16.h, left: 24.w, right: 24.w),
                height: 64.h,
                borderRadius: BorderRadius.circular(20.r),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Image.asset(serviceItem.image, width: 24.w, height: 24.h),
                    SizedBox(width: 16.w),
                    Text(
                      serviceItem.text,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.theme.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Text(
                        serviceItem.subText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: context.theme.textPrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Image.asset(
                        'assets/images/img_55.png',
                        width: 16.w,
                        height: 16.h,
                        color: context.theme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
