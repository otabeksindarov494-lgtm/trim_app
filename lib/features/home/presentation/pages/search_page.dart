import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trim_app/features/salon/presentation/bloc/salon_state.dart';
import 'package:trim_app/features/profile/presentation/pages/profile_page.dart';

import 'package:trim_app/features/salon/presentation/bloc/salon_bloc.dart';
import 'package:trim_app/features/salon/presentation/bloc/salon_event.dart';
import 'package:trim_app/theme/app_theme.dart';
import 'package:trim_app/widgets/common/glass.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool hasText = false;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  final List<String> recentSearches = [
    'Uncle Chill',
    'Genesis',
    'Santander',
  ];

  @override
  void initState() {
    super.initState();
    context.read<SalonBloc>().add(SalonsRequested());
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
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

  double dragOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backdropLight,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            setState(() {
              dragOffset += details.delta.dy;

              if (dragOffset > MediaQuery.of(context).size.height) {
                dragOffset = MediaQuery.of(context).size.height;
              }
            });
          }
        },
        onVerticalDragEnd: (details) {
          if (dragOffset > 150 || (details.primaryVelocity ?? 0) > 700) {
            Navigator.pop(context);
          } else {
            setState(() {
              dragOffset = 0;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.only(top: 68.h),
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                GlassContainer(
                  width: 380.w,
                  height: 56.h,
                    borderRadius: BorderRadius.circular(16.r),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: context.theme.textSecondary, size: 24.r),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              focusNode: searchFocus,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: context.theme.textPrimary,
                              ),
                              onChanged: (text) {
                                setState(() {
                                  hasText = text.isNotEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintText: "Поиск...",
                                hintStyle: TextStyle(
                                  color: context.theme.textSecondary,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          if (hasText)
                            GestureDetector(
                              onTap: () {
                                searchController.clear();
                                setState(() {
                                  hasText = false;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: context.theme.textSecondary,
                                size: 20.r,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: BlocBuilder<SalonBloc, SalonState>(
                    builder: (context, state) {
                      if (state is SalonLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is SalonLoaded) {
                        final query = searchController.text.trim().toLowerCase();
                        final filteredSalons = query.isEmpty
                            ? state.salons
                            : state.salons.where((s) {
                                return s.title.toLowerCase().contains(query) ||
                                    s.podcastCount.toLowerCase().contains(query);
                              }).toList();

                        if (filteredSalons.isEmpty) {
                          return Center(
                            child: Text(
                              'Ничего не найдено',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: context.theme.textSecondary,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: filteredSalons.length,
                          itemBuilder: (context, index) {
                            final salon = filteredSalons[index];
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
                                margin: EdgeInsets.only(bottom: 16.h),
                                padding: EdgeInsets.all(12.r),
                                borderRadius: BorderRadius.circular(16.r),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: _buildSalonImage(
                                        salon.image,
                                        width: 60.w,
                                        height: 60.h,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
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
                                          SizedBox(height: 4.h),
                                          Text(
                                            salon.podcastCount,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: context.theme.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: const Color(0xFFFFAB38), size: 16.r),
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
        ),
      ),
    );
  }
}
