import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/salon/presentation/bloc/salon_bloc.dart';
import 'package:trim_app/features/salon/presentation/bloc/salon_event.dart';
import 'package:trim_app/features/salon/presentation/bloc/salon_state.dart';
import 'package:trim_app/features/profile/presentation/pages/profile_page.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<String> interests = ['Все', 'Стрижки', 'Макияж', 'Маникюр'];
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    context.read<SalonBloc>().add(SalonsRequested());
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
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/img_5.png',
                    width: 28.w,
                    height: 28.h,
                    color: context.theme.textPrimary,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Избранное',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textPrimary,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: Image.asset(
                    'assets/images/img_30.png',
                    width: 28.w,
                    height: 28.h,
                    color: context.theme.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 33.h),
            SizedBox(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: interests.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: categoryButton(
                      interests[index],
                      index == isSelected,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: BlocBuilder<SalonBloc, SalonState>(
                builder: (context, state) {
                  if (state is SalonLoading || state is SalonInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SalonError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: context.theme.textPrimary),
                      ),
                    );
                  }

                  if (state is SalonLoaded) {
                    final salons = state.salons;

                    if (salons.isEmpty) {
                      return Center(
                        child: Text(
                          'Избранные салоны пока отсутствуют',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: context.theme.textSecondary,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      itemCount: salons.length,
                      itemBuilder: (context, index) {
                        final salon = salons[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfilePage(
                                  profile: salon,
                                  listImage: const [],
                                ),
                              ),
                            );
                          },
                          child: GlassContainer(
                            margin: EdgeInsets.only(bottom: 20.h),
                            padding: EdgeInsets.all(16.r),
                            borderRadius: BorderRadius.circular(20.r),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: _buildSalonImage(
                                    salon.image,
                                    width: 80.w,
                                    height: 80.h,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        salon.title,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                          color: context.theme.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        salon.podcastCount,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: context.theme.textSecondary,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 16.r,
                                            color: const Color(0xFFFFAB38),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '${salon.rating}',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: context.theme.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.bookmark,
                                  color: const Color(0xFFFFAB38),
                                  size: 24.r,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String text, bool selected) {
    return Container(
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
    );
  }
}
