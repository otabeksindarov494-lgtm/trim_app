import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/bloc/salon_bloc/salon_state.dart';
import 'package:trim_app/home_menu/notification_page.dart' hide subscriptions;
import 'package:trim_app/home_menu/search_page.dart' hide subscriptions;
import 'package:trim_app/l10n/app_localizations.dart';
import 'package:trim_app/profile/action_page.dart';
import 'package:trim_app/profile/profile_page.dart';
import '../bloc/provider/repository/salon_repository.dart';
import '../bloc/salon_bloc/salon_bloc.dart';
import '../bloc/salon_bloc/salon_event.dart';
import 'favorites_page.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key, required this.listImage});

  final List<ListImage> listImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SalonBloc(repository: SalonRepository())..add(SalonsRequested()),
      child: _HomeMenuBody(listImage: listImage),
    );
  }
}

class _HomeMenuBody extends StatefulWidget {
  const _HomeMenuBody({required this.listImage});

  final List<ListImage> listImage;

  @override
  State<_HomeMenuBody> createState() => _HomeMenuBodyState();
}

class _HomeMenuBodyState extends State<_HomeMenuBody> {
  bool hasText = false;

  final TextEditingController controller = TextEditingController();

  final List<String> interestKeys = ['all', 'haircuts', 'makeup', 'manicure'];
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 68.h),
        child: ListView(
          padding: EdgeInsets.only(bottom: appNavBarHeight(context) + 5.h),
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 24.w),
                    Image.asset(
                      'assets/images/img_9.png',
                      width: 34.w,
                      height: 34.h,
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'TrimApp',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/img_10.png',
                          width: 28.w,
                          height: 28.h,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FavoritesPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/img_11.png',
                          width: 28.w,
                          height: 28.h,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 29.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,

                        barrierColor: Colors.black.withOpacity(0.15),

                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const SearchPage();
                        },

                        transitionDuration: const Duration(milliseconds: 400),

                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return SlideTransition(
                                position:
                                    Tween<Offset>(
                                      begin: const Offset(0, 1),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOutCubic,
                                      ),
                                    ),
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Container(
                    width: 380.w,
                    height: 58.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Color(0xffF5F5F5),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20.w),
                        Image.asset(
                          'assets/images/img_13.png',
                          width: 17.w,
                          height: 18.h,
                        ),
                        SizedBox(width: 15.w),
                        Text(
                          context.tr('search'),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffBDBDBD),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Image.asset(
                  'assets/images/discount_banner_tight.png',
                  width: 380.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    Image.asset(
                      'assets/images/img_15.png',
                      width: 73.w,
                      height: 90.h,
                    ),
                    SizedBox(width: 35.w),
                    Image.asset(
                      'assets/images/img_14.png',
                      width: 60.w,
                      height: 90.h,
                    ),
                    SizedBox(width: 35.w),
                    Image.asset(
                      'assets/images/img_16.png',
                      width: 68.w,
                      height: 90.h,
                    ),
                    SizedBox(width: 35.w),
                    Image.asset(
                      'assets/images/img_17.png',
                      width: 63.w,
                      height: 90.h,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Divider(
                  height: 1.h,
                  thickness: 2,
                  endIndent: 20.w,
                  indent: 20.w,
                  color: Color(0xffEEEEEE),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    SizedBox(width: 24.w),
                    Text(
                      context.tr('near_you'),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: Text(
                        context.tr('all'),
                        style: TextStyle(
                          color: Color(0xffFD9203),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: interestKeys.length,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
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
                BlocBuilder<SalonBloc, SalonState>(
                  builder: (context, state) {
                    if (state is SalonLoading || state is SalonInitial) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if(state is SalonError) {
                      return Padding(padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: Text('Ошибко ${state.message}'),),
                      );
                    }
                    final salons = (state as SalonLoaded).salons;

                    if(salons.isEmpty) {
                      return Padding(padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: Text('salon topilmadi'),),
                      );
                    }

                    return Column(
                      children: salons.map((subscription) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  profile: subscription,
                                  listImage: widget.listImage,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 24.h),
                            width: 380.w,
                            height: 110.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              color: Color(0xffFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffE9E9E9),
                                  blurRadius: 24.r,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.w, top: 15.h),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: _buildSalonImage(
                                        subscription.image,
                                        width: 80.w,
                                        height: 80.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              subscription.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: 24.w,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.read<SalonBloc>().add(
                                                        ToggleFavoriteRequested(
                                                          salonId: subscription.id,
                                                          currentStatus:
                                                              subscription.isEnabled,
                                                        ),
                                                      );
                                                },
                                                child: subscription.isEnabled
                                                    ? Image.asset(
                                                        'assets/images/img_29.png',
                                                        width: 24.w,
                                                        height: 24.h,
                                                      )
                                                    : Image.asset(
                                                        'assets/images/img_26.png',
                                                        width: 24.w,
                                                        height: 24.h,
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          subscription.podcastCount,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Color(0xff616161),
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/img_24.png',
                                                  width: 16.w,
                                                  height: 16.h,
                                                ),
                                                SizedBox(width: 2.w),
                                                Text(
                                                  '1.2 km',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 25.w),
                                            Image.asset(
                                              'assets/images/img_25.png',
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                            SizedBox(width: 2.w),
                                            Text(
                                              '4.2',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalonImage(String imagePath, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/img_23.png',
          width: width,
          height: height,
          fit: fit,
        ),
      );
    } else if (imagePath.isNotEmpty) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Image.asset(
          'assets/images/img_23.png',
          width: width,
          height: height,
          fit: fit,
        ),
      );
    } else {
      return Image.asset(
        'assets/images/img_23.png',
        width: width,
        height: height,
        fit: fit,
      );
    }
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
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFD9301) : Colors.white,
          borderRadius: BorderRadius.circular(150.r),
          border: Border.all(color: const Color(0xFFFD9301), width: 2),
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

  double appNavBarHeight(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const designAllowance = 20.0;
    final extraInset = (bottomInset - designAllowance).clamp(
      0.0,
      double.infinity,
    );
    return 100.h + extraInset;
  }
}
