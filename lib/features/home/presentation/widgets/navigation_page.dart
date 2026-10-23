import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/profile/presentation/pages/change_profile.dart';
import 'package:trim_app/features/chat/presentation/pages/chat_page.dart';
import 'package:trim_app/features/home/presentation/pages/map_page.dart';
import 'package:trim_app/features/home/presentation/pages/order_page.dart';
import 'package:trim_app/core/l10n/app_localizations.dart';
import 'package:trim_app/features/profile/presentation/pages/action_page.dart';
import 'package:trim_app/features/home/presentation/pages/home_menu.dart';
import 'package:trim_app/theme/app_theme.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, required this.listImage});
  final List<ListImage> listImage;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  var currentIndex = 0;
  late final List<Widget> pages = [
    HomeMenu(listImage: widget.listImage),
    const MapPage(),
    const OrderPage(),
    const ChatPage(),
    const ChangeProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const designAllowance = 20.0;
    final extraInset = (bottomInset - designAllowance).clamp(0.0, double.infinity);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IndexedStack(index: currentIndex, children: pages),
          Positioned(
            left: 0.w,
            right: 0.w,
            bottom: 0.h,
            child: ClipRRect(
              child: Container(
                height: 110.h + extraInset,
                decoration: BoxDecoration(color: context.theme.surface),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h + extraInset),
                      width: 380.w,
                      height: 68.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.r),
                        border: Border.all(color: context.theme.border, width: 2),
                        color: context.theme.surface,
                      ),
                      child: Row(
                        children: [
                          navItem(0, 'assets/images/img_18.png', context.tr('home')),
                          navItem(1, 'assets/images/img_19.png', context.tr('map')),
                          navItem(2, 'assets/images/img_20.png', context.tr('orders')),
                          navItem(3, 'assets/images/img_21.png', context.tr('chat')),
                          navItem(4, 'assets/images/img_22.png', context.tr('profile')),
                        ],
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

  Widget navItem(int index, String image, String label) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 24.w,
              height: 24.h,
              color: isSelected ? const Color(0xffFA9400) : context.theme.textSecondary,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: isSelected ? const Color(0xffFA9400) : context.theme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
